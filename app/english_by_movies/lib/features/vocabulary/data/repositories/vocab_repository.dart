import 'package:english_by_movies/features/vocabulary/data/datasources/vocab_api.dart';
import 'package:english_by_movies/features/vocabulary/data/models/vocab_word.dart';

class VocabRepository {
  final VocabApi api;

  VocabRepository(this.api);

  Future<List<VocabWord>> getAll() => api.list();

  Future<void> addWord(VocabWord word) => api.upsert(
    lemma: word.lemma,
    display: word.display,
    definition: word.definition,
    ipa: word.ipa,
    example: word.example,
  );

  Future<void> deleteWord(int id) => api.delete(id);
}
