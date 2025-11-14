namespace Domain.Entities;

public class User
{
    public Guid UserId { get; set; }
    public string Email { get; set; } = default!;
    public string? DisplayName { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
