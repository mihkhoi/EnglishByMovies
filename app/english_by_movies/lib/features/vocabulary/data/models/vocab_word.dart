class VocabWord {
  final int vocabId;
  final String lemma;
  final String display;
  final String? definition;
  final String? ipa;
  final String? example;
  final int lookups;
  final bool mastered;

  VocabWord({
    required this.vocabId,
    required this.lemma,
    required this.display,
    this.definition,
    this.ipa,
    this.example,
    required this.lookups,
    required this.mastered,
  });

  factory VocabWord.fromJson(Map<String, dynamic> json) {
    return VocabWord(
      vocabId: json['vocabId'] as int,
      lemma: json['lemma'] as String,
      display: json['display'] as String,
      definition: json['definition'] as String?,
      ipa: json['ipa'] as String?,
      example: json['example'] as String?,
      lookups: (json['lookups'] ?? 0) as int,
      mastered: (json['mastered'] ?? false) as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'vocabId': vocabId,
    'lemma': lemma,
    'display': display,
    'definition': definition,
    'ipa': ipa,
    'example': example,
    'lookups': lookups,
    'mastered': mastered,
  };
}
