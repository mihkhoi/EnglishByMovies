namespace Domain.Entities;

public class Word
{
    public long WordId { get; set; }
    public string Lemma { get; set; } = default!;
    public string LanguageCode { get; set; } = "en";
    public string? IPA { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}
