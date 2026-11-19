

namespace Designly.Models.Concerns;


public abstract class AuthAccount : SqlServerModel
{
    
    public abstract string PasswordHash { get; set; }

    
    public abstract int GetKey();

    public string GetAuthPassword()
    {
        return PasswordHash;
    }

    public string GetRememberTokenName()
    {
        return "";
    }

    public void SetRememberToken(string? value)
    {
        
    }
}
