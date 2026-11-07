
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET NOCOUNT ON;
GO
USE designly_db;
GO

/* 1. admin */
SET IDENTITY_INSERT dbo.admin ON;
INSERT INTO dbo.admin (admin_id, full_name, email, password_hash, phone) VALUES
    (1, N'Alanood Alzhrani', N'alanood.alzhrani@designly.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 55 310 4821'),
    (2, N'Turki Almutairi', N'turki.almutairi@designly.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 54 772 1906');
SET IDENTITY_INSERT dbo.admin OFF;
GO

/* 2. store_admin (4 = waiting for approval, 5 = suspended) */
SET IDENTITY_INSERT dbo.store_admin ON;
INSERT INTO dbo.store_admin (STadmin_id, admin_id, full_name, email, password_hash, phone, created_at, account_status) VALUES
    (1, 1, N'Mishail Alshiban', N'mishail@maisonliving.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 50 418 2275', N'2026-01-12 09:30:00', N'Active'),
    (2, 1, N'Arwa Almalki', N'arwa@nordvikhome.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 56 230 9814', N'2026-01-20 11:05:00', N'Active'),
    (3, 1, N'Khalid Alzahrani', N'khalid@oakandco.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 53 905 6142', N'2026-02-03 13:40:00', N'Active'),
    (4, 2, N'Lulwa Alshammari', N'lulwa@almajlisinteriors.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 58 144 7390', N'2026-10-10 16:20:00', N'Pending'),
    (5, 2, N'Majed Alqahtani', N'majed@daralathath.sa', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 59 661 0237', N'2026-03-08 10:15:00', N'Suspended');
SET IDENTITY_INSERT dbo.store_admin OFF;
GO

/* 3. customer (1 = main demo customer, 8 = suspended → SH-03) */
SET IDENTITY_INSERT dbo.customer ON;
INSERT INTO dbo.customer (customer_id, admin_id, first_name, last_name, email, password_hash, phone, city, account_status, created_at) VALUES
    (1, 1, N'Shahad', N'Alqahtani', N'shahad.alqahtani@gmail.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 55 812 4470', N'Jubail', N'Active', N'2026-02-14 18:22:00'),
    (2, 1, N'Remas', N'Sanbou', N'remas.sanbou@gmail.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 50 937 2618', N'Riyadh', N'Active', N'2026-02-18 20:10:00'),
    (3, 1, N'Noura', N'Alsubaie', N'noura.alsubaie@hotmail.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 54 201 7735', N'Riyadh', N'Active', N'2026-03-02 12:45:00'),
    (4, 1, N'Omar', N'Alfahad', N'omar.alfahad@outlook.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 53 448 9021', N'Dammam', N'Active', N'2026-03-11 09:05:00'),
    (5, 2, N'Sara', N'Alkhaldi', N'sara.alkhaldi@gmail.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 56 703 1158', N'Jeddah', N'Active', N'2026-04-06 21:30:00'),
    (6, 2, N'Abdullah', N'Alshehri', N'abdullah.alshehri@gmail.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 57 362 8840', N'Abha', N'Active', N'2026-04-19 17:15:00'),
    (7, 2, N'Reem', N'Alharbi', N'reem.alharbi@yahoo.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 58 590 4467', N'Medina', N'Active', N'2026-05-27 14:00:00'),
    (8, 1, N'Fahad', N'Alotaibi', N'fahad.alotaibi@gmail.com', N'$2y$10$J4eyO6nIhvbH0RhH3Qs5WOs1sy3fXsSWH5q64A71RrD7OyaRQ6m4G', N'+966 59 125 6603', N'Mecca', N'Suspended', N'2026-06-09 19:40:00');
SET IDENTITY_INSERT dbo.customer OFF;
GO

/* 4. store (avg_rating = average of its store_review rows) */
SET IDENTITY_INSERT dbo.store ON;
INSERT INTO dbo.store (store_id, STadmin_id, store_name, commercial_reg, city, address, phone, avg_rating, store_status) VALUES
    (1, 1, N'Maison Living', N'1010734512', N'Riyadh', N'King Fahd Rd, Al Olaya, Riyadh 12214', N'+966 55 101 2030', 4.7, N'Active'),
    (2, 2, N'Nordvik Home', N'4030418827', N'Jeddah', N'Prince Sultan Rd, Al Zahra, Jeddah 23425', N'+966 56 404 5577', 4.7, N'Active'),
    (3, 3, N'Oak & Co.', N'2050276390', N'Dammam', N'King Saud St, Al Faisaliyah, Dammam 32272', N'+966 53 818 2244', 4.5, N'Active'),
    (4, 4, N'Al Majlis Interiors', N'2051093364', N'Khobar', N'Prince Turki St, Al Corniche, Khobar 34413', N'+966 58 300 9912', NULL, N'Pending'),
    (5, 5, N'Dar Al Athath', N'1010558841', N'Riyadh', N'Takhassusi St, Al Rahmaniyah, Riyadh 12341', N'+966 59 707 1188', NULL, N'Suspended');
SET IDENTITY_INSERT dbo.store OFF;
GO

/* 5. product */
SET IDENTITY_INSERT dbo.product ON;
INSERT INTO dbo.product (product_id, store_id, product_name, product_type, category, price, discount_percent, warranty_months, available_colors, width_cm, length_cm, height_cm, specifications, stock_qty, image_url, description) VALUES
    (1, 1, N'Alden Three-Seat Sofa', N'Furniture', N'Sofas & Seating', 2999.00, 15, 24, N'#2c4f7c,#8a9a7e,#c9ab7a,#3a3a3a', 220, 90, 82, N'Frame: Kiln-dried hardwood, high-density foam · Upholstery: Brushed velvet · Base: Solid oak', 12, N'uploads/products/sofa.jpg', N'A deep-seat three-cushion sofa upholstered in brushed velvet, with a solid oak base. Designed to anchor a living room and pair easily with the Senna coffee table and Halden floor lamp.'),
    (2, 1, N'Birch Storage Cabinet', N'Furniture', N'Storage', 1199.00, 10, 12, N'#c9ab7a,#f3e0b4,#3a3a3a', 120, 45, 85, N'Material: Birch veneer on MDF · Doors: 2 sliding · Shelves: 4 adjustable', 9, N'uploads/products/cabinet.jpg', N'A low sideboard in light birch with two sliding doors and four adjustable shelves — wide enough for a TV and slim enough for a hallway.'),
    (3, 1, N'Sahar Queen Bed', N'Furniture', N'Beds', 3450.00, 0, 36, N'#f3e0b4,#8a9a7e,#3a3a3a', 168, 212, 110, N'Frame: Solid beech wood · Headboard: Linen upholstery · Mattress size: 160 × 200 cm', 5, N'uploads/products/bed.jpg', N'A queen bed with a padded linen headboard and a solid beech frame. Slatted base included; mattress sold separately.'),
    (4, 1, N'Layal Round Wall Mirror', N'Decor', N'Decor', 290.00, 0, 0, N'#c9ab7a,#b2862f', 80, 4, 80, N'Frame: Woven rattan · Glass: 5 mm silver mirror · Fixing: Wall hook included', 20, N'uploads/products/mirror.jpg', N'A round mirror framed in hand-woven rattan that brings warmth and light to an entryway or above a console.'),
    (5, 1, N'Najd Wool Area Rug', N'Decor', N'Decor', 680.00, 0, 0, N'#c9ab7a,#f3e0b4,#2c4f7c', 200, 140, 1, N'Material: Hand-tufted wool · Pile height: 12 mm · Backing: Cotton canvas', 14, N'uploads/products/rug.jpg', N'A soft hand-tufted wool rug with a subtle geometric border inspired by Najdi patterns.'),
    (6, 2, N'Senna Coffee Table', N'Furniture', N'Tables', 745.00, 0, 12, N'#c9ab7a,#3a3a3a', 110, 60, 42, N'Top: Solid ash wood · Legs: Powder-coated steel · Finish: Matte lacquer', 18, N'uploads/products/table.jpg', N'A rectangular coffee table with a solid ash top and slim steel legs — low enough for a deep sofa.'),
    (7, 2, N'Marlow Leather Armchair', N'Furniture', N'Sofas & Seating', 1890.00, 0, 24, N'#c9ab7a,#3a3a3a,#2c4f7c', 80, 85, 90, N'Upholstery: Full-grain leather · Frame: Solid pine · Legs: Oiled oak', 7, N'uploads/products/armchair.jpg', N'A mid-century armchair in full-grain leather with a curved back and oiled oak legs.'),
    (8, 2, N'Fjord Dining Table', N'Furniture', N'Tables', 2200.00, 10, 24, N'#c9ab7a,#3a3a3a', 180, 90, 75, N'Top: Solid oak · Seats: 6 people · Finish: Natural oil', 6, N'uploads/products/dining-table.jpg', N'A six-seat dining table in solid oak with a natural oil finish that deepens with age.'),
    (9, 2, N'Fjord Dining Chair', N'Furniture', N'Sofas & Seating', 340.00, 0, 12, N'#c9ab7a,#3a3a3a,#8a9a7e', 45, 50, 80, N'Frame: Steam-bent beech · Seat: Solid wood · Stackable: No', 40, N'uploads/products/dining-chair.jpg', N'A spindle-back dining chair in steam-bent beech, made to match the Fjord dining table.'),
    (10, 2, N'Asker Writing Desk', N'Furniture', N'Tables', 1150.00, 0, 12, N'#c9ab7a,#f3e0b4', 110, 55, 76, N'Material: Walnut veneer · Drawers: 2 · Cable hole: Yes', 8, N'uploads/products/desk.jpg', N'A compact writing desk with two drawers and a hidden cable hole — sized for a home office corner.'),
    (11, 3, N'Halden Floor Lamp', N'Furniture', N'Lighting', 389.00, 0, 12, N'#b2862f,#3a3a3a,#f3e0b4', 40, 40, 160, N'Body: Brushed brass · Shade: Linen drum · Bulb: E27, max 60 W', 25, N'uploads/products/lamp.jpg', N'A slender floor lamp with a brushed brass stem and a linen drum shade that gives a soft, even glow.'),
    (12, 3, N'Rustic Oak Bench', N'Furniture', N'Sofas & Seating', 420.00, 0, 12, N'#c9ab7a,#3a3a3a', 120, 35, 45, N'Material: Reclaimed oak · Finish: Wax · Max load: 200 kg', 11, N'uploads/products/stool.jpg', N'A sturdy bench in reclaimed oak for an entryway, a dining table or the foot of a bed.'),
    (13, 3, N'Lina Ceramic Vase', N'Decor', N'Decor', 349.00, 0, 0, N'#2c4f7c,#f3e0b4,#8a9a7e', 18, 18, 35, N'Material: Glazed stoneware · Handmade: Yes · Watertight: Yes', 30, N'uploads/products/vase.jpg', N'A tall handmade stoneware vase with a reactive glaze — every piece is slightly different.'),
    (14, 3, N'Oak Ladder Bookshelf', N'Furniture', N'Storage', 960.00, 5, 12, N'#c9ab7a,#3a3a3a', 80, 35, 180, N'Material: Solid oak · Shelves: 5 · Wall anchor: Included', 10, N'uploads/products/bookshelf.jpg', N'A five-shelf bookshelf in solid oak with an open back that keeps a small room feeling light.'),
    (15, 3, N'Qamar Pendant Light', N'Furniture', N'Lighting', 520.00, 0, 12, N'#f3e0b4,#b2862f', 45, 45, 60, N'Shade: Opal glass · Cord: Adjustable 1.5 m · Bulb: E27, max 40 W', 15, N'uploads/products/pendant.jpg', N'An opal glass pendant on an adjustable brass cord — hang it over a dining table or a bedside.');
SET IDENTITY_INSERT dbo.product OFF;
GO

/* 6. room_design (1–3 = UC1-10 "My Designs" of the main customer) */
SET IDENTITY_INSERT dbo.room_design ON;
INSERT INTO dbo.room_design (design_id, customer_id, design_name, room_type, room_width, room_length, room_height, is_public, share_link, preview_image, created_at, updated_at) VALUES
    (1, 1, N'Soft Morning Lounge', N'Living Room', 4.20, 3.60, 2.80, 0, N'k7Qm2xVt9Lp4', N'uploads/designs/living.jpg', N'2026-09-28 19:10:00', N'2026-10-15 08:05:00'),
    (2, 1, N'Warm Minimal Nook', N'Bedroom', 3.80, 3.40, 2.80, 1, N'p3Rw8nHc5Za1', N'uploads/designs/bedroom.jpg', N'2026-09-20 21:00:00', N'2026-10-12 17:40:00'),
    (3, 1, N'Round Table Gathering', N'Dining Room', 4.00, 3.50, 2.90, 0, NULL, N'uploads/designs/dining.jpg', N'2026-09-01 16:30:00', N'2026-10-08 13:20:00'),
    (4, 2, N'Majlis Evening Lounge', N'Living Room', 5.00, 4.00, 3.00, 1, N'b9Tf4kWe2Ys6', N'uploads/designs/living.jpg', N'2026-08-14 20:00:00', N'2026-09-30 22:10:00'),
    (5, 3, N'Blue Hour Reading Corner', N'Living Room', 3.60, 3.20, 2.80, 1, N'h2Lc7vNq8Dm3', N'uploads/designs/living.jpg', N'2026-09-05 18:45:00', N'2026-10-11 10:00:00'),
    (6, 5, N'Olive Dining Nook', N'Dining Room', 3.60, 3.20, 2.90, 1, N'x5Gd1rJp6Wk8', N'uploads/designs/dining.jpg', N'2026-09-12 15:15:00', N'2026-10-02 19:30:00'),
    (7, 4, N'Quiet Study Corner', N'Home Office', 3.00, 2.80, 2.70, 1, N'm8Vb3sQe7Tn2', N'uploads/designs/bedroom.jpg', N'2026-07-22 11:00:00', N'2026-09-26 09:45:00'),
    (8, 7, N'First Apartment Bedroom', N'Bedroom', 3.40, 3.20, 2.70, 0, NULL, NULL, N'2026-10-14 22:05:00', N'2026-10-14 22:05:00');
SET IDENTITY_INSERT dbo.room_design OFF;
GO

/* 7. design_item (every footprint lies inside its room; positions are item centres in metres) */
SET IDENTITY_INSERT dbo.design_item ON;
INSERT INTO dbo.design_item (design_item_id, design_id, product_id, position_x, position_y, rotation_angle, selected_color, quantity, position_z) VALUES
    (1, 1, 1, 1.20, 2.40, 90, N'#2c4f7c', 1, 0.00),
    (2, 1, 6, 2.30, 2.40, 90, N'#c9ab7a', 1, 0.00),
    (3, 1, 11, 0.40, 0.50, 0, N'#b2862f', 1, 0.00),
    (4, 1, 2, 3.40, 0.30, 0, N'#c9ab7a', 1, 0.00),
    (5, 1, 7, 3.40, 2.60, 270, N'#c9ab7a', 1, 0.00),
    (6, 1, 5, 2.30, 2.40, 0, N'#f3e0b4', 1, 0.00),
    (7, 1, 13, 3.10, 0.30, 0, N'#2c4f7c', 3, 0.85),
    (8, 1, 4, 1.60, 0.05, 0, N'#c9ab7a', 1, 1.20),
    (9, 2, 3, 1.90, 1.20, 0, N'#f3e0b4', 1, 0.00),
    (10, 2, 15, 0.60, 0.40, 0, N'#f3e0b4', 2, 2.10),
    (11, 2, 5, 1.90, 2.60, 0, N'#c9ab7a', 1, 0.00),
    (12, 2, 4, 3.75, 1.80, 90, N'#b2862f', 1, 1.30),
    (13, 2, 12, 1.90, 2.55, 0, N'#c9ab7a', 1, 0.00),
    (14, 3, 8, 2.00, 1.75, 0, N'#c9ab7a', 1, 0.00),
    (15, 3, 9, 2.00, 0.95, 0, N'#c9ab7a', 3, 0.00),
    (16, 3, 9, 2.00, 2.55, 180, N'#3a3a3a', 3, 0.00),
    (17, 3, 15, 2.00, 1.75, 0, N'#b2862f', 1, 2.20),
    (18, 3, 13, 3.70, 0.30, 0, N'#8a9a7e', 1, 0.00),
    (19, 4, 1, 2.50, 3.50, 0, N'#8a9a7e', 1, 0.00),
    (20, 4, 7, 0.80, 2.00, 90, N'#3a3a3a', 2, 0.00),
    (21, 4, 6, 2.50, 2.40, 0, N'#3a3a3a', 1, 0.00),
    (22, 4, 5, 2.50, 2.40, 0, N'#2c4f7c', 1, 0.00),
    (23, 4, 11, 4.60, 3.60, 0, N'#3a3a3a', 1, 0.00),
    (24, 5, 7, 0.70, 0.70, 0, N'#2c4f7c', 1, 0.00),
    (25, 5, 11, 1.40, 0.40, 0, N'#b2862f', 1, 0.00),
    (26, 5, 14, 3.10, 0.25, 0, N'#c9ab7a', 2, 0.00),
    (27, 5, 5, 1.00, 1.40, 90, N'#2c4f7c', 1, 0.00),
    (28, 6, 8, 1.80, 1.60, 0, N'#3a3a3a', 1, 0.00),
    (29, 6, 9, 1.80, 0.80, 0, N'#8a9a7e', 2, 0.00),
    (30, 6, 9, 1.80, 2.40, 180, N'#8a9a7e', 2, 0.00),
    (31, 6, 15, 1.80, 1.60, 0, N'#f3e0b4', 1, 2.20),
    (32, 7, 10, 1.50, 0.35, 0, N'#c9ab7a', 1, 0.00),
    (33, 7, 14, 0.25, 1.60, 90, N'#c9ab7a', 1, 0.00),
    (34, 7, 11, 2.70, 0.40, 0, N'#3a3a3a', 1, 0.00),
    (35, 7, 4, 2.95, 1.60, 270, N'#c9ab7a', 1, 1.20);
SET IDENTITY_INSERT dbo.design_item OFF;
GO

/* 8. saved_product (6 for the main customer → SH-10) */
SET IDENTITY_INSERT dbo.saved_product ON;
INSERT INTO dbo.saved_product (saved_id, customer_id, product_id, saved_date) VALUES
    (1, 1, 1, N'2026-10-13 21:14:00'),
    (2, 1, 11, N'2026-10-11 18:02:00'),
    (3, 1, 7, N'2026-10-08 22:40:00'),
    (4, 1, 12, N'2026-10-01 20:05:00'),
    (5, 1, 13, N'2026-09-26 17:30:00'),
    (6, 1, 9, N'2026-09-21 13:15:00'),
    (7, 2, 3, N'2026-09-29 23:10:00'),
    (8, 2, 14, N'2026-10-03 16:45:00'),
    (9, 3, 8, N'2026-10-06 20:20:00'),
    (10, 4, 10, N'2026-09-14 10:00:00'),
    (11, 5, 15, N'2026-10-09 19:55:00'),
    (12, 6, 4, N'2026-10-12 11:35:00');
SET IDENTITY_INSERT dbo.saved_product OFF;
GO

/* 9. store_review (each after a Delivered order that contained the store's products) */
SET IDENTITY_INSERT dbo.store_review ON;
INSERT INTO dbo.store_review (review_id, customer_id, store_id, star_rating, comment, review_date) VALUES
    (1, 1, 1, 5, N'The Alden sofa is even more comfortable than it looks, and it fit my living room exactly as I planned it in Designly.', N'2026-08-08 20:15:00'),
    (2, 2, 1, 4, N'Beautiful sofa and careful packaging. Delivery took one day longer than the estimate.', N'2026-08-17 18:30:00'),
    (3, 2, 2, 5, N'The Senna table is solid and the finish is perfect. Great communication from the store.', N'2026-08-17 18:34:00'),
    (4, 3, 3, 5, N'The Halden lamp gives a lovely warm light. Express delivery arrived the next day.', N'2026-08-28 21:00:00'),
    (5, 3, 2, 4, N'Great quality armchair, the leather is soft. The legs needed tightening after assembly.', N'2026-08-28 21:06:00'),
    (6, 4, 3, 4, N'Good bookshelf and pendant. The bookshelf instructions could be clearer.', N'2026-09-15 19:40:00'),
    (7, 4, 2, 5, N'The Asker desk is exactly the right size for my study corner.', N'2026-09-15 19:45:00'),
    (8, 6, 1, 5, N'The Sahar bed is sturdy and the headboard fabric is high quality. Very happy.', N'2026-10-01 22:10:00');
SET IDENTITY_INSERT dbo.store_review OFF;
GO

/* 10. orders (#DL-{order_id}; 10055/10204/10311/10482/10520 = SH-07 order history) */
SET IDENTITY_INSERT dbo.orders ON;
INSERT INTO dbo.orders (order_id, customer_id, order_date, order_total_amount, commission_amount, order_status) VALUES
    (10055, 1, N'2026-08-02 19:22:00', 3318.00, 165.90, N'Delivered'),
    (10088, 2, N'2026-08-11 13:05:00', 3294.00, 164.70, N'Delivered'),
    (10150, 3, N'2026-08-24 21:40:00', 2314.00, 115.70, N'Delivered'),
    (10204, 1, N'2026-09-02 17:48:00', 745.00, 37.25, N'Cancelled'),
    (10260, 4, N'2026-09-09 12:10:00', 2582.00, 129.10, N'Delivered'),
    (10311, 1, N'2026-09-18 20:31:00', 2279.00, 113.95, N'Delivered'),
    (10430, 6, N'2026-09-27 10:55:00', 3775.00, 188.75, N'Delivered'),
    (10455, 5, N'2026-09-30 22:18:00', 3340.00, 167.00, N'Pending Payment'),
    (10482, 1, N'2026-10-01 10:14:00', 5151.00, 257.55, N'Shipped'),
    (10501, 7, N'2026-10-02 18:40:00', 1413.00, 70.65, N'Placed'),
    (10520, 1, N'2026-10-03 16:02:00', 1468.00, 73.40, N'Processing');
SET IDENTITY_INSERT dbo.orders OFF;
GO

/* 11. order_item */
SET IDENTITY_INSERT dbo.order_item ON;
INSERT INTO dbo.order_item (order_item_id, order_id, product_id, quantity, unit_price, selected_color, subtotal) VALUES
    (1, 10055, 1, 1, 2549.00, N'#8a9a7e', 2549.00),
    (2, 10055, 12, 1, 420.00, N'#c9ab7a', 420.00),
    (3, 10055, 13, 1, 349.00, N'#2c4f7c', 349.00),
    (4, 10088, 1, 1, 2549.00, N'#2c4f7c', 2549.00),
    (5, 10088, 6, 1, 745.00, N'#c9ab7a', 745.00),
    (6, 10150, 11, 1, 389.00, N'#b2862f', 389.00),
    (7, 10150, 7, 1, 1890.00, N'#2c4f7c', 1890.00),
    (8, 10204, 6, 1, 745.00, N'#3a3a3a', 745.00),
    (9, 10260, 14, 1, 912.00, N'#c9ab7a', 912.00),
    (10, 10260, 15, 1, 520.00, N'#f3e0b4', 520.00),
    (11, 10260, 10, 1, 1150.00, N'#c9ab7a', 1150.00),
    (12, 10311, 7, 1, 1890.00, N'#c9ab7a', 1890.00),
    (13, 10311, 11, 1, 389.00, N'#3a3a3a', 389.00),
    (14, 10430, 3, 1, 3450.00, N'#f3e0b4', 3450.00),
    (15, 10430, 4, 1, 290.00, N'#b2862f', 290.00),
    (16, 10455, 8, 1, 1980.00, N'#c9ab7a', 1980.00),
    (17, 10455, 9, 4, 340.00, N'#c9ab7a', 1360.00),
    (18, 10482, 1, 1, 2549.00, N'#2c4f7c', 2549.00),
    (19, 10482, 6, 1, 745.00, N'#c9ab7a', 745.00),
    (20, 10482, 11, 2, 389.00, N'#b2862f', 778.00),
    (21, 10482, 2, 1, 1079.00, N'#c9ab7a', 1079.00),
    (22, 10501, 5, 1, 680.00, N'#c9ab7a', 680.00),
    (23, 10501, 13, 2, 349.00, N'#f3e0b4', 698.00),
    (24, 10520, 11, 1, 389.00, N'#f3e0b4', 389.00),
    (25, 10520, 2, 1, 1079.00, N'#f3e0b4', 1079.00);
SET IDENTITY_INSERT dbo.order_item OFF;
GO

/* 12. payment (one per order; 10455 failed → UC2-09; 10204 refunded after cancel) */
SET IDENTITY_INSERT dbo.payment ON;
INSERT INTO dbo.payment (payment_id, order_id, total_amount, vat_amount, transaction_ref, payment_method, payment_status, payment_date, discount_amount) VALUES
    (1, 10055, 3318.00, 432.78, N'TXN-10055-7Q4K', N'Visa', N'Paid', N'2026-08-02 19:22:00', 450.00),
    (2, 10088, 3294.00, 429.65, N'TXN-10088-2M9X', N'Mada', N'Paid', N'2026-08-11 13:05:00', 450.00),
    (3, 10150, 2314.00, 301.83, N'TXN-10150-5R1C', N'Visa', N'Paid', N'2026-08-24 21:40:00', 0.00),
    (4, 10204, 745.00, 97.17, N'TXN-10204-8T6P', N'Visa', N'Refunded', N'2026-09-02 17:48:00', 0.00),
    (5, 10260, 2582.00, 336.78, N'TXN-10260-3H2W', N'Mastercard', N'Paid', N'2026-09-09 12:10:00', 48.00),
    (6, 10311, 2279.00, 297.26, N'TXN-10311-9D4L', N'Mastercard', N'Paid', N'2026-09-18 20:31:00', 0.00),
    (7, 10430, 3775.00, 492.39, N'TXN-10430-6B8N', N'Mada', N'Paid', N'2026-09-27 10:55:00', 0.00),
    (8, 10455, 3340.00, 435.65, NULL, N'Visa', N'Failed', N'2026-09-30 22:18:00', 220.00),
    (9, 10482, 5151.00, 671.87, N'TXN-10482-1K5V', N'Visa', N'Paid', N'2026-10-01 10:14:00', 570.00),
    (10, 10501, 1413.00, 184.30, N'TXN-10501-0J3S', N'Apple Pay', N'Paid', N'2026-10-02 18:40:00', 0.00),
    (11, 10520, 1468.00, 191.48, N'TXN-10520-2W6E', N'Visa', N'Paid', N'2026-10-03 16:02:00', 120.00);
SET IDENTITY_INSERT dbo.payment OFF;
GO

/* 13. shipment */
SET IDENTITY_INSERT dbo.shipment ON;
INSERT INTO dbo.shipment (shipment_id, order_id, carrier_name, tracking_number, shipped_date, delivered_date, shipment_status) VALUES
    (1, 10055, N'Aramex', N'ARX-55031846', N'2026-08-03 10:40:00', N'2026-08-06 15:05:00', N'Delivered'),
    (2, 10088, N'SMSA Express', N'SMSA-71338402', N'2026-08-12 09:20:00', N'2026-08-15 12:30:00', N'Delivered'),
    (3, 10150, N'Naqel Express', N'NQL-20947713', N'2026-08-25 08:15:00', N'2026-08-26 17:50:00', N'Delivered'),
    (4, 10204, NULL, NULL, NULL, NULL, N'Cancelled'),
    (5, 10260, N'SPL', N'SPL-RR482230115SA', N'2026-09-10 11:30:00', N'2026-09-13 14:00:00', N'Delivered'),
    (6, 10311, N'SMSA Express', N'SMSA-74190263', N'2026-09-19 10:05:00', N'2026-09-22 16:20:00', N'Delivered'),
    (7, 10430, N'Aramex', N'ARX-55290417', N'2026-09-28 09:00:00', N'2026-09-29 13:45:00', N'Delivered'),
    (8, 10455, NULL, NULL, NULL, NULL, N'Preparing'),
    (9, 10482, N'SMSA Express', N'SMSA-77204915', N'2026-10-02 09:05:00', NULL, N'Shipped'),
    (10, 10501, NULL, NULL, NULL, NULL, N'Preparing'),
    (11, 10520, NULL, NULL, NULL, NULL, N'Preparing');
SET IDENTITY_INSERT dbo.shipment OFF;
GO

/* 14. delivery */
SET IDENTITY_INSERT dbo.delivery ON;
INSERT INTO dbo.delivery (delivery_id, shipment_id, recipient_name, phone, delivery_address, city, delivery_method, delivery_fee, estimated_delivery_date, delivery_status) VALUES
    (1, 1, N'Shahad Alqahtani', N'+966 55 812 4470', N'Al Fanateer, Building 14, Jubail', N'Jubail', N'Standard', 0, N'2026-08-07', N'Delivered'),
    (2, 2, N'Remas Sanbou', N'+966 50 937 2618', N'Al Malqa, Anas Bin Malik Rd, Riyadh', N'Riyadh', N'Standard', 0, N'2026-08-16', N'Delivered'),
    (3, 3, N'Noura Alsubaie', N'+966 54 201 7735', N'Al Yasmin, Al Thumamah Rd, Riyadh', N'Riyadh', N'Express', 35, N'2026-08-26', N'Delivered'),
    (4, 4, N'Shahad Alqahtani', N'+966 55 812 4470', N'Al Fanateer, Building 14, Jubail', N'Jubail', N'Standard', 0, N'2026-09-07', N'Cancelled'),
    (5, 5, N'Omar Alfahad', N'+966 53 448 9021', N'Al Shati, Prince Mohammed Bin Fahd Rd, Dammam', N'Dammam', N'Standard', 0, N'2026-09-14', N'Delivered'),
    (6, 6, N'Shahad Alqahtani', N'+966 55 812 4470', N'Al Fanateer, Building 14, Jubail', N'Jubail', N'Standard', 0, N'2026-09-23', N'Delivered'),
    (7, 7, N'Abdullah Alshehri', N'+966 57 362 8840', N'Al Mansak, King Khalid Rd, Abha', N'Abha', N'Express', 35, N'2026-09-29', N'Delivered'),
    (8, 8, N'Sara Alkhaldi', N'+966 56 703 1158', N'Al Rawdah, Prince Sultan St, Jeddah', N'Jeddah', N'Standard', 0, N'2026-10-05', N'Scheduled'),
    (9, 9, N'Shahad Alqahtani', N'+966 55 812 4470', N'Al Fanateer, Building 14, Jubail', N'Jubail', N'Standard', 0, N'2026-10-06', N'In Transit'),
    (10, 10, N'Reem Alharbi', N'+966 58 590 4467', N'Quba, Abu Bakr Al Siddiq Rd, Medina', N'Medina', N'Express', 35, N'2026-10-04', N'Scheduled'),
    (11, 11, N'Shahad Alqahtani', N'+966 55 812 4470', N'Al Fanateer, Building 14, Jubail', N'Jubail', N'Standard', 0, N'2026-10-08', N'Scheduled');
SET IDENTITY_INSERT dbo.delivery OFF;
GO

/* 15. credit_card */
SET IDENTITY_INSERT dbo.credit_card ON;
INSERT INTO dbo.credit_card (card_id, customer_id, cardHolderName, lastFourDigits, expiryDate, cardType) VALUES
    (1, 1, N'Shahad Alqahtani', N'4242', N'09/28', N'Visa'),
    (2, 1, N'Shahad Alqahtani', N'8810', N'02/27', N'Mastercard'),
    (3, 2, N'Remas Sanbou', N'5521', N'11/27', N'Mada'),
    (4, 3, N'Noura Alsubaie', N'1881', N'06/29', N'Visa'),
    (5, 4, N'Omar Alfahad', N'4410', N'03/28', N'Mastercard'),
    (6, 5, N'Sara Alkhaldi', N'0019', N'12/26', N'Visa'),
    (7, 6, N'Abdullah Alshehri', N'7302', N'08/28', N'Mada'),
    (8, 7, N'Reem Alharbi', N'3365', N'05/30', N'Visa');
SET IDENTITY_INSERT dbo.credit_card OFF;
GO

PRINT 'designly_db: sample data inserted.';
GO
