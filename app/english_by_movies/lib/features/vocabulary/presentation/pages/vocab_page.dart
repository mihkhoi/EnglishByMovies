import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:english_by_movies/features/vocabulary/presentation/providers/vocab_providers.dart';
import 'package:english_by_movies/features/vocabulary/presentation/widgets/vocab_list_tile.dart';

class VocabPage extends ConsumerWidget {
  const VocabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vocabListProvider);
    final notifier = ref.read(vocabListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Từ vựng của tôi')),
      body: state.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Chưa có từ nào, hãy thêm!'));
          }
          return RefreshIndicator(
            onRefresh: notifier.load,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) => VocabListTile(
                item: items[i],
                onDelete: () => notifier.delete(items[i].vocabId),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final controller = TextEditingController();
          final result = await showDialog<String>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Thêm từ'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Nhập một từ tiếng Anh',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Huỷ'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context, controller.text.trim()),
                  child: const Text('Lưu'),
                ),
              ],
            ),
          );

          if (result != null && result.isNotEmpty) {
            await notifier.addSimple(result);
          }
        },
      ),
    );
  }
}
