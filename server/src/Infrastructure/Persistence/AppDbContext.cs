using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Persistence;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> opt) : base(opt) { }

    public DbSet<User> Users => Set<User>();
    public DbSet<Word> Words => Set<Word>();
    public DbSet<VocabularyEntry> VocabularyEntries => Set<VocabularyEntry>();

    protected override void OnModelCreating(ModelBuilder b)
    {
        b.Entity<User>().HasKey(x => x.UserId);
        b.Entity<User>().HasIndex(x => x.Email).IsUnique();
        b.Entity<User>().Property(x => x.Email).HasMaxLength(256).IsRequired();

        b.Entity<Word>().HasKey(x => x.WordId);
        b.Entity<Word>().HasIndex(x => new { x.Lemma, x.LanguageCode }).IsUnique();
        b.Entity<Word>().Property(x => x.Lemma).HasMaxLength(128).IsRequired();
        b.Entity<Word>().Property(x => x.LanguageCode).HasMaxLength(16).IsRequired();

        b.Entity<VocabularyEntry>().HasKey(x => x.VocabId);
        b.Entity<VocabularyEntry>()
            .HasOne(x => x.Word)
            .WithMany()
            .HasForeignKey(x => x.WordId)
            .OnDelete(DeleteBehavior.Cascade);

        b.Entity<VocabularyEntry>().HasIndex(x => new { x.UserId, x.WordId }).IsUnique();
        b.Entity<VocabularyEntry>().Property(x => x.Display).HasMaxLength(128).IsRequired();

        base.OnModelCreating(b);
    }
}
