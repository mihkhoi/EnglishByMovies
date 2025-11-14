using Domain.Entities;
using Infrastructure.Persistence;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Api.Controllers;

[ApiController]
[Route("api/v1/vocab")]
public class VocabController : ControllerBase
{
    private readonly AppDbContext _db;
    public VocabController(AppDbContext db) => _db = db;

    [HttpGet]
    public async Task<IActionResult> List()
    {
        var userId = Guid.Parse("00000000-0000-0000-0000-000000000001");

        var items = await _db.VocabularyEntries
            .Include(v => v.Word)
            .Where(v => v.UserId == userId && !v.IsDeleted)
            .OrderByDescending(v => v.UpdatedAt)
            .Select(v => new {
                v.VocabId,
                lemma = v.Word.Lemma,
                v.Display,
                v.Definition,
                v.IPA,
                v.Example,
                v.Lookups,
                v.Mastered,
                v.CreatedAt,
                v.UpdatedAt
            })
            .ToListAsync();

        return Ok(items);
    }

    public sealed record UpsertVocabDto(string Lemma, string Display, string? Definition, string? IPA, string? Example);

    [HttpPost]
    public async Task<IActionResult> Upsert([FromBody] UpsertVocabDto dto)
    {
        var userId = Guid.Parse("00000000-0000-0000-0000-000000000001");

        var word = await _db.Words.FirstOrDefaultAsync(w => w.Lemma == dto.Lemma && w.LanguageCode == "en");
        if (word is null)
        {
            word = new Word { Lemma = dto.Lemma, LanguageCode = "en", IPA = dto.IPA };
            _db.Words.Add(word);
            await _db.SaveChangesAsync();
        }

        var entry = await _db.VocabularyEntries
            .FirstOrDefaultAsync(v => v.UserId == userId && v.WordId == word.WordId && !v.IsDeleted);

        if (entry is null)
        {
            entry = new VocabularyEntry
            {
                UserId = userId,
                WordId = word.WordId,
                Display = dto.Display,
                Definition = dto.Definition,
                IPA = dto.IPA,
                Example = dto.Example
            };
            _db.VocabularyEntries.Add(entry);
        }
        else
        {
            entry.Display = dto.Display;
            entry.Definition = dto.Definition ?? entry.Definition;
            entry.IPA = dto.IPA ?? entry.IPA;
            entry.Example = dto.Example ?? entry.Example;
            entry.Lookups += 1;
            entry.UpdatedAt = DateTime.UtcNow;
        }

        await _db.SaveChangesAsync();
        return NoContent();
    }

    [HttpDelete("{id:long}")]
    public async Task<IActionResult> Delete(long id)
    {
        var userId = Guid.Parse("00000000-0000-0000-0000-000000000001");

        var entry = await _db.VocabularyEntries
            .FirstOrDefaultAsync(v => v.VocabId == id && v.UserId == userId && !v.IsDeleted);

        if (entry is null) return NotFound();

        entry.IsDeleted = true;
        entry.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();

        return NoContent();
    }
}
