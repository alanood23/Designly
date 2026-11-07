red order uses them.
   ===================================================================== */
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET NOCOUNT ON;
GO

IF DB_ID(N'designly_db') IS NULL
    CREATE DATABASE designly_db;
GO
USE designly_db;
GO

/* ---------------------------------------------------------------------
   1. admin
   --------------------------------------------------------------------- */
CREATE TABLE dbo.admin (
    admin_id       INT IDENTITY(1,1) NOT NULL,
    full_name      NVARCHAR(100)     NOT NULL,
    email          VARCHAR(150)      NOT NULL,
    password_hash  VARCHAR(255)      NOT NULL,
    phone          VARCHAR(16)       NOT NULL,                 -- '+966 5X XXX XXXX'
    CONSTRAINT PK_admin PRIMARY KEY (admin_id),
    CONSTRAINT UQ_admin_email UNIQUE (email),
    CONSTRAINT CK_admin_phone CHECK (phone LIKE '+966 5[0-9] [0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
);
GO

/* ---------------------------------------------------------------------
   2. store_admin (ERD: STORE_ADMIN — the store owner)
   --------------------------------------------------------------------- */
CREATE TABLE dbo.store_admin (
    STadmin_id      INT IDENTITY(1,1) NOT NULL,
    admin_id        INT               NOT NULL,                -- the admin who manages (approved) this owner
    full_name       NVARCHAR(100)     NOT NULL,
    email           VARCHAR(150)      NOT NULL,
    password_hash   VARCHAR(255)      NOT NULL,
    phone           VARCHAR(16)       NOT NULL,
    created_at      DATETIME2(0)      NOT NULL CONSTRAINT DF_store_admin_created DEFAULT (SYSDATETIME()),
    account_status  VARCHAR(10)       NOT NULL CONSTRAINT DF_store_admin_status DEFAULT ('Pending'),  -- [UI] D2 "approve / block store owner accounts"
    CONSTRAINT PK_store_admin PRIMARY KEY (STadmin_id),
    CONSTRAINT UQ_store_admin_email UNIQUE (email),
    CONSTRAINT UQ_store_admin_phone UNIQUE (phone),
    CONSTRAINT CK_store_admin_phone CHECK (phone LIKE '+966 5[0-9] [0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_store_admin_status CHECK (account_status IN ('Pending', 'Active', 'Suspended')),
    CONSTRAINT FK_store_admin_admin FOREIGN KEY (admin_id) REFERENCES dbo.admin (admin_id)
);
GO

/* ---------------------------------------------------------------------
   3. customer
   --------------------------------------------------------------------- */
CREATE TABLE dbo.customer (
    customer_id     INT IDENTITY(1,1) NOT NULL,
    admin_id        INT               NOT NULL,                -- the admin who manages the account
    first_name      NVARCHAR(50)      NOT NULL,
    last_name       NVARCHAR(50)      NOT NULL,
    email           VARCHAR(150)      NOT NULL,
    password_hash   VARCHAR(255)      NOT NULL,
    phone           VARCHAR(16)       NOT NULL,
    city            NVARCHAR(50)      NULL,
    account_status  VARCHAR(10)       NOT NULL CONSTRAINT DF_customer_status DEFAULT ('Active'),
    created_at      DATETIME2(0)      NOT NULL CONSTRAINT DF_customer_created DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_customer PRIMARY KEY (customer_id),
    CONSTRAINT UQ_customer_email UNIQUE (email),
    CONSTRAINT UQ_customer_phone UNIQUE (phone),
    CONSTRAINT CK_customer_phone CHECK (phone LIKE '+966 5[0-9] [0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_customer_status CHECK (account_status IN ('Active', 'Suspended')),
    CONSTRAINT FK_customer_admin FOREIGN KEY (admin_id) REFERENCES dbo.admin (admin_id)
);
GO

/* ---------------------------------------------------------------------
   4. store
   --------------------------------------------------------------------- */
CREATE TABLE dbo.store (
    store_id        INT IDENTITY(1,1) NOT NULL,
    STadmin_id      INT               NOT NULL,
    store_name      NVARCHAR(100)     NOT NULL,
    commercial_reg  VARCHAR(10)       NOT NULL,                -- Saudi CR number, 10 digits
    city            NVARCHAR(50)      NOT NULL,
    address         NVARCHAR(250)     NOT NULL,
    phone           VARCHAR(16)       NOT NULL,
    avg_rating      DECIMAL(2,1)      NULL,                    -- average of store_review.star_rating, kept by the app
    store_status    VARCHAR(10)       NOT NULL CONSTRAINT DF_store_status DEFAULT ('Pending'),
    CONSTRAINT PK_store PRIMARY KEY (store_id),
    CONSTRAINT UQ_store_name UNIQUE (store_name),
    CONSTRAINT UQ_store_cr UNIQUE (commercial_reg),
    CONSTRAINT CK_store_cr CHECK (commercial_reg LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_store_phone CHECK (phone LIKE '+966 5[0-9] [0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_store_rating CHECK (avg_rating BETWEEN 1 AND 5),
    CONSTRAINT CK_store_status CHECK (store_status IN ('Pending', 'Active', 'Suspended')),
    CONSTRAINT FK_store_store_admin FOREIGN KEY (STadmin_id) REFERENCES dbo.store_admin (STadmin_id)
);
GO

/* ---------------------------------------------------------------------
   5. product
   --------------------------------------------------------------------- */
CREATE TABLE dbo.product (
    product_id        INT IDENTITY(1,1) NOT NULL,
    store_id          INT               NOT NULL,
    product_name      NVARCHAR(100)     NOT NULL,
    product_type      VARCHAR(10)       NOT NULL,              -- Furniture / Decor
    category          VARCHAR(30)       NOT NULL,
    price             DECIMAL(9,2)      NOT NULL,              -- list price before the discount
    discount_percent  INT               NOT NULL CONSTRAINT DF_product_discount DEFAULT (0),
    warranty_months   INT               NOT NULL CONSTRAINT DF_product_warranty DEFAULT (0),
    available_colors  VARCHAR(120)      NOT NULL,              -- comma-separated hex swatches, e.g. '#2c4f7c,#3a3a3a'
    width_cm          INT               NOT NULL,
    length_cm         INT               NOT NULL,              -- the depth shown as "Depth"
    height_cm         INT               NOT NULL,
    specifications    NVARCHAR(500)     NULL,                  -- e.g. 'Frame: Kiln-dried hardwood, high-density foam'
    stock_qty         INT               NOT NULL,
    image_url         NVARCHAR(500)     NOT NULL,              -- 'uploads/products/…' or a URL
    description       NVARCHAR(1000)    NULL,                  -- [UI] the "Description" paragraph on Product Detail
    CONSTRAINT PK_product PRIMARY KEY (product_id),
    CONSTRAINT UQ_product_name UNIQUE (store_id, product_name),
    CONSTRAINT CK_product_type CHECK (product_type IN ('Furniture', 'Decor')),
    CONSTRAINT CK_product_category CHECK (category IN ('Sofas & Seating', 'Tables', 'Lighting', 'Storage', 'Beds', 'Decor')),
    CONSTRAINT CK_product_price CHECK (price BETWEEN 10 AND 100000),
    CONSTRAINT CK_product_discount CHECK (discount_percent BETWEEN 0 AND 70),
    CONSTRAINT CK_product_warranty CHECK (warranty_months BETWEEN 0 AND 120),
    CONSTRAINT CK_product_dims CHECK (width_cm BETWEEN 1 AND 1500 AND length_cm BETWEEN 1 AND 1500 AND height_cm BETWEEN 1 AND 1500),
    CONSTRAINT CK_product_stock CHECK (stock_qty >= 0),
    CONSTRAINT FK_product_store FOREIGN KEY (store_id) REFERENCES dbo.store (store_id)
);
CREATE INDEX IX_product_catalog ON dbo.product (category, store_id) INCLUDE (price, discount_percent, stock_qty);
GO

/* ---------------------------------------------------------------------
   6. room_design
   --------------------------------------------------------------------- */
CREATE TABLE dbo.room_design (
    design_id      INT IDENTITY(1,1) NOT NULL,
    customer_id    INT               NOT NULL,
    design_name    NVARCHAR(80)      NOT NULL,
    room_type      VARCHAR(15)       NOT NULL,
    room_width     DECIMAL(4,2)      NOT NULL,                 -- metres, 1–15
    room_length    DECIMAL(4,2)      NOT NULL,
    room_height    DECIMAL(4,2)      NOT NULL,
    is_public      BIT               NOT NULL CONSTRAINT DF_design_public DEFAULT (0),
    share_link     VARCHAR(40)       NULL,                     -- random token of the shareable link (/d/{token})
    preview_image  NVARCHAR(500)     NULL,                     -- 'uploads/designs/…' snapshot saved with the design, or a URL
    created_at     DATETIME2(0)      NOT NULL CONSTRAINT DF_design_created DEFAULT (SYSDATETIME()),
    updated_at     DATETIME2(0)      NOT NULL CONSTRAINT DF_design_updated DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_room_design PRIMARY KEY (design_id),
    CONSTRAINT CK_design_type CHECK (room_type IN ('Living Room', 'Bedroom', 'Dining Room', 'Home Office')),
    CONSTRAINT CK_design_dims CHECK (room_width BETWEEN 1 AND 15 AND room_length BETWEEN 1 AND 15 AND room_height BETWEEN 1 AND 15),
    CONSTRAINT CK_design_updated CHECK (updated_at >= created_at),
    CONSTRAINT FK_design_customer FOREIGN KEY (customer_id) REFERENCES dbo.customer (customer_id)
);
CREATE UNIQUE INDEX UX_design_share ON dbo.room_design (share_link) WHERE share_link IS NOT NULL;
GO

/* ---------------------------------------------------------------------
   7. design_item — a product placed in a room design (top-down position in metres)
   --------------------------------------------------------------------- */
CREATE TABLE dbo.design_item (
    design_item_id  INT IDENTITY(1,1) NOT NULL,
    design_id       INT               NOT NULL,
    product_id      INT               NOT NULL,
    position_x      DECIMAL(5,2)      NOT NULL,                -- metres from the left wall to the item's centre
    position_y      DECIMAL(5,2)      NOT NULL,                -- metres from the top wall to the item's centre
    rotation_angle  INT               NOT NULL CONSTRAINT DF_item_rotation DEFAULT (0),
    selected_color  VARCHAR(7)        NOT NULL,                -- one of the product's available_colors
    quantity        INT               NOT NULL CONSTRAINT DF_item_qty DEFAULT (1),
    position_z      DECIMAL(5,2)      NOT NULL CONSTRAINT DF_item_z DEFAULT (0),   -- height above the floor (0 = on the floor)
    CONSTRAINT PK_design_item PRIMARY KEY (design_item_id),
    CONSTRAINT CK_item_rotation CHECK (rotation_angle BETWEEN 0 AND 359 AND rotation_angle % 15 = 0),
    CONSTRAINT CK_item_qty CHECK (quantity BETWEEN 1 AND 10),
    CONSTRAINT CK_item_pos CHECK (position_x >= 0 AND position_y >= 0 AND position_z >= 0),
    CONSTRAINT CK_item_color CHECK (selected_color LIKE '#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'),
    CONSTRAINT FK_item_design FOREIGN KEY (design_id) REFERENCES dbo.room_design (design_id) ON DELETE CASCADE,
    CONSTRAINT FK_item_product FOREIGN KEY (product_id) REFERENCES dbo.product (product_id)
);
CREATE INDEX IX_item_design ON dbo.design_item (design_id);
GO

/* ---------------------------------------------------------------------
   8. saved_product (wishlist)
   --------------------------------------------------------------------- */
CREATE TABLE dbo.saved_product (
    saved_id     INT IDENTITY(1,1) NOT NULL,
    customer_id  INT               NOT NULL,
    product_id   INT               NOT NULL,
    saved_date   DATETIME2(0)      NOT NULL CONSTRAINT DF_saved_date DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_saved_product PRIMARY KEY (saved_id),
    CONSTRAINT UQ_saved_product UNIQUE (customer_id, product_id),          -- D3 duplicate prevention
    CONSTRAINT FK_saved_customer FOREIGN KEY (customer_id) REFERENCES dbo.customer (customer_id),
    CONSTRAINT FK_saved_product FOREIGN KEY (product_id) REFERENCES dbo.product (product_id)
);
GO

/* ---------------------------------------------------------------------
   9. store_review
   --------------------------------------------------------------------- */
CREATE TABLE dbo.store_review (
    review_id    INT IDENTITY(1,1) NOT NULL,
    customer_id  INT               NOT NULL,
    store_id     INT               NOT NULL,
    star_rating  INT               NOT NULL,
    comment      NVARCHAR(1000)    NULL,
    review_date  DATETIME2(0)      NOT NULL CONSTRAINT DF_review_date DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_store_review PRIMARY KEY (review_id),
    CONSTRAINT CK_review_rating CHECK (star_rating BETWEEN 1 AND 5),
    CONSTRAINT FK_review_customer FOREIGN KEY (customer_id) REFERENCES dbo.customer (customer_id),
    CONSTRAINT FK_review_store FOREIGN KEY (store_id) REFERENCES dbo.store (store_id)
);
GO

/* ---------------------------------------------------------------------
   10. orders (ERD: ORDER) — one order can mix products of several stores
   Shown as #DL-{order_id}
   --------------------------------------------------------------------- */
CREATE TABLE dbo.orders (
    order_id            INT IDENTITY(10001,1) NOT NULL,
    customer_id         INT               NOT NULL,
    order_date          DATETIME2(0)      NOT NULL CONSTRAINT DF_orders_date DEFAULT (SYSDATETIME()),
    order_total_amount  DECIMAL(10,2)     NOT NULL,            -- items subtotal + delivery fee (VAT included in prices)
    commission_amount   DECIMAL(10,2)     NOT NULL,            -- 5 % of order_total_amount
    order_status        VARCHAR(16)       NOT NULL CONSTRAINT DF_orders_status DEFAULT ('Pending Payment'),
    CONSTRAINT PK_orders PRIMARY KEY (order_id),
    CONSTRAINT CK_orders_total CHECK (order_total_amount > 0),
    CONSTRAINT CK_orders_commission CHECK (commission_amount = ROUND(order_total_amount * 0.05, 2)),
    CONSTRAINT CK_orders_status CHECK (order_status IN ('Pending Payment', 'Placed', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    CONSTRAINT FK_orders_customer FOREIGN KEY (customer_id) REFERENCES dbo.customer (customer_id)
);
CREATE INDEX IX_orders_customer ON dbo.orders (customer_id, order_date DESC);
GO

/* ---------------------------------------------------------------------
   11. order_item
   --------------------------------------------------------------------- */
CREATE TABLE dbo.order_item (
    order_item_id   INT IDENTITY(1,1) NOT NULL,
    order_id        INT               NOT NULL,
    product_id      INT               NOT NULL,
    quantity        INT               NOT NULL,
    unit_price      DECIMAL(9,2)      NOT NULL,                -- price after the product discount, at order time
    selected_color  VARCHAR(7)        NOT NULL,
    subtotal        DECIMAL(10,2)     NOT NULL,
    CONSTRAINT PK_order_item PRIMARY KEY (order_item_id),
    CONSTRAINT UQ_order_item UNIQUE (order_id, product_id, selected_color),
    CONSTRAINT CK_order_item_qty CHECK (quantity BETWEEN 1 AND 10),
    CONSTRAINT CK_order_item_sub CHECK (subtotal = unit_price * quantity),
    CONSTRAINT CK_order_item_color CHECK (selected_color LIKE '#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'),
    CONSTRAINT FK_order_item_order FOREIGN KEY (order_id) REFERENCES dbo.orders (order_id),
    CONSTRAINT FK_order_item_product FOREIGN KEY (product_id) REFERENCES dbo.product (product_id)
);
CREATE INDEX IX_order_item_product ON dbo.order_item (product_id);
GO

/* ---------------------------------------------------------------------
   12. payment — exactly one per order (a retry updates the same row)
   --------------------------------------------------------------------- */
CREATE TABLE dbo.payment (
    payment_id       INT IDENTITY(1,1) NOT NULL,
    order_id         INT               NOT NULL,
    total_amount     DECIMAL(10,2)     NOT NULL,               -- = order_total_amount
    vat_amount       DECIMAL(10,2)     NOT NULL,               -- 15 % VAT included in the total (total × 15 / 115)
    transaction_ref  VARCHAR(40)       NULL,
    payment_method   VARCHAR(12)       NOT NULL,
    payment_status   VARCHAR(10)       NOT NULL CONSTRAINT DF_payment_status DEFAULT ('Pending'),
    payment_date     DATETIME2(0)      NOT NULL CONSTRAINT DF_payment_date DEFAULT (SYSDATETIME()),
    discount_amount  DECIMAL(10,2)     NOT NULL CONSTRAINT DF_payment_discount DEFAULT (0),   -- Σ product discounts in the order
    CONSTRAINT PK_payment PRIMARY KEY (payment_id),
    CONSTRAINT UQ_payment_order UNIQUE (order_id),
    CONSTRAINT CK_payment_vat CHECK (vat_amount = ROUND(total_amount * 15 / 115, 2)),
    CONSTRAINT CK_payment_method CHECK (payment_method IN ('Visa', 'Mastercard', 'Mada', 'Apple Pay')),
    CONSTRAINT CK_payment_status CHECK (payment_status IN ('Pending', 'Failed', 'Paid', 'Refunded')),
    CONSTRAINT CK_payment_ref CHECK (payment_status NOT IN ('Paid', 'Refunded') OR transaction_ref IS NOT NULL),
    CONSTRAINT CK_payment_discount CHECK (discount_amount >= 0),
    CONSTRAINT FK_payment_order FOREIGN KEY (order_id) REFERENCES dbo.orders (order_id)
);
CREATE UNIQUE INDEX UX_payment_ref ON dbo.payment (transaction_ref) WHERE transaction_ref IS NOT NULL;
GO

/* ---------------------------------------------------------------------
   13. shipment — one per order, created with the order; carrier and tracking when shipped
   --------------------------------------------------------------------- */
CREATE TABLE dbo.shipment (
    shipment_id      INT IDENTITY(1,1) NOT NULL,
    order_id         INT               NOT NULL,
    carrier_name     NVARCHAR(60)      NULL,
    tracking_number  VARCHAR(40)       NULL,
    shipped_date     DATETIME2(0)      NULL,
    delivered_date   DATETIME2(0)      NULL,
    shipment_status  VARCHAR(12)       NOT NULL CONSTRAINT DF_shipment_status DEFAULT ('Preparing'),
    CONSTRAINT PK_shipment PRIMARY KEY (shipment_id),
    CONSTRAINT UQ_shipment_order UNIQUE (order_id),
    CONSTRAINT CK_shipment_status CHECK (shipment_status IN ('Preparing', 'Shipped', 'Delivered', 'Cancelled')),
    CONSTRAINT CK_shipment_shipped CHECK ((shipment_status IN ('Shipped', 'Delivered') AND carrier_name IS NOT NULL AND tracking_number IS NOT NULL AND shipped_date IS NOT NULL)
                                       OR shipment_status IN ('Preparing', 'Cancelled')),
    CONSTRAINT CK_shipment_delivered CHECK ((shipment_status = 'Delivered' AND delivered_date >= shipped_date) OR (shipment_status <> 'Delivered' AND delivered_date IS NULL)),
    CONSTRAINT FK_shipment_order FOREIGN KEY (order_id) REFERENCES dbo.orders (order_id)
);
GO

/* ---------------------------------------------------------------------
   14. delivery — recipient and method entered at checkout
   --------------------------------------------------------------------- */
CREATE TABLE dbo.delivery (
    delivery_id              INT IDENTITY(1,1) NOT NULL,
    shipment_id              INT               NOT NULL,
    recipient_name           NVARCHAR(100)     NOT NULL,
    phone                    VARCHAR(16)       NOT NULL,
    delivery_address         NVARCHAR(250)     NOT NULL,
    city                     NVARCHAR(50)      NOT NULL,
    delivery_method          VARCHAR(10)       NOT NULL,
    delivery_fee             DECIMAL(7,2)      NOT NULL,
    estimated_delivery_date  DATE              NOT NULL,
    delivery_status          VARCHAR(12)       NOT NULL CONSTRAINT DF_delivery_status DEFAULT ('Scheduled'),
    CONSTRAINT PK_delivery PRIMARY KEY (delivery_id),
    CONSTRAINT UQ_delivery_shipment UNIQUE (shipment_id),
    CONSTRAINT CK_delivery_phone CHECK (phone LIKE '+966 5[0-9] [0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_delivery_method CHECK ((delivery_method = 'Standard' AND delivery_fee = 0) OR (delivery_method = 'Express' AND delivery_fee = 35)),
    CONSTRAINT CK_delivery_status CHECK (delivery_status IN ('Scheduled', 'In Transit', 'Delivered', 'Cancelled')),
    CONSTRAINT FK_delivery_shipment FOREIGN KEY (shipment_id) REFERENCES dbo.shipment (shipment_id)
);
GO

/* ---------------------------------------------------------------------
   15. credit_card (ERD: CreditCard) — only holder, last 4 digits, expiry and type are stored
   --------------------------------------------------------------------- */
CREATE TABLE dbo.credit_card (
    card_id         INT IDENTITY(1,1) NOT NULL,
    customer_id     INT               NOT NULL,
    cardHolderName  NVARCHAR(60)      NOT NULL,
    lastFourDigits  CHAR(4)           NOT NULL,
    expiryDate      CHAR(5)           NOT NULL,                -- 'MM/YY'
    cardType        VARCHAR(12)       NOT NULL,
    CONSTRAINT PK_credit_card PRIMARY KEY (card_id),
    CONSTRAINT UQ_card UNIQUE (customer_id, cardType, lastFourDigits, expiryDate),
    CONSTRAINT CK_card_last4 CHECK (lastFourDigits LIKE '[0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_card_expiry CHECK (expiryDate LIKE '[0-1][0-9]/[0-9][0-9]' AND LEFT(expiryDate, 2) BETWEEN '01' AND '12'),
    CONSTRAINT CK_card_type CHECK (cardType IN ('Visa', 'Mastercard', 'Mada')),
    CONSTRAINT FK_card_customer FOREIGN KEY (customer_id) REFERENCES dbo.customer (customer_id)
);
GO

PRINT 'designly_db: 15 tables created.';
GO
