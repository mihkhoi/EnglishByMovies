namespace Domain.Entities;

public class VocabularyEntry
{
    public long VocabId { get; set; }
    public Guid UserId { get; set; }
    public long WordId { get; set; }

    public string Display { get; set; } = default!;
    public string? Definition { get; set; }
    public string? IPA { get; set; }
    public string? Example { get; set; }

    public int Lookups { get; set; } = 1;
    public bool Mastered { get; set; } = false;
    public bool IsDeleted { get; set; } = false;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

    public Word Word { get; set; } = default!;
}
