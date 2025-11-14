import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:english_by_movies/features/vocabulary/data/datasources/vocab_api.dart';
import 'package:english_by_movies/features/vocabulary/data/models/vocab_word.dart';
import 'package:english_by_movies/features/vocabulary/data/repositories/vocab_repository.dart';

final vocabApiProvider = rp.Provider<VocabApi>((ref) => VocabApi());

final vocabRepositoryProvider = rp.Provider<VocabRepository>(
  (ref) => VocabRepository(ref.read(vocabApiProvider)),
);

final vocabListProvider =
    rp.StateNotifierProvider<VocabListNotifier, rp.AsyncValue<List<VocabWord>>>(
      (ref) => VocabListNotifier(ref.read(vocabRepositoryProvider)),
    );

class VocabListNotifier
    extends rp.StateNotifier<rp.AsyncValue<List<VocabWord>>> {
  final VocabRepository repo;

  VocabListNotifier(this.repo) : super(const rp.AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const rp.AsyncValue.loading();
    try {
      final items = await repo.getAll();
      state = rp.AsyncValue.data(items);
    } catch (e, st) {
      state = rp.AsyncValue.error(e, st);
    }
  }

  Future<void> addSimple(String word) async {
    final newWord = VocabWord(
      vocabId: 0,
      lemma: word,
      display: word,
      definition: null,
      ipa: null,
      example: null,
      lookups: 1,
      mastered: false,
    );
    await repo.addWord(newWord);
    await load();
  }

  Future<void> delete(int id) async {
    await repo.deleteWord(id);
    await load();
  }
}
