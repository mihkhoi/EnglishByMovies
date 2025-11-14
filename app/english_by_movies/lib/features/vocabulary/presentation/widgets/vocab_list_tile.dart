import 'package:flutter/material.dart';
import 'package:english_by_movies/features/vocabulary/data/models/vocab_word.dart';

class VocabListTile extends StatelessWidget {
  final VocabWord item;
  final VoidCallback? onDelete;

  const VocabListTile({super.key, required this.item, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.display),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.ipa != null) Text('/${item.ipa}/'),
          if (item.definition != null) Text(item.definition!),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
