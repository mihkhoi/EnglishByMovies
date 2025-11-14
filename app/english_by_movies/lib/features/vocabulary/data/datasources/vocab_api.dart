import 'package:dio/dio.dart';
import 'package:english_by_movies/app/env.dart';
import '../models/vocab_word.dart';

class VocabApi {
  late final Dio _dio;

  VocabApi({Dio? dio}) {
    _dio = dio ?? Dio(BaseOptions(baseUrl: Env.apiBaseUrl));
  }

  Future<List<VocabWord>> list() async {
    final res = await _dio.get('/api/v1/vocab');
    final list = (res.data as List).cast<Map<String, dynamic>>();
    return list.map(VocabWord.fromJson).toList();
  }

  Future<void> upsert({
    required String lemma,
    required String display,
    String? definition,
    String? ipa,
    String? example,
  }) async {
    await _dio.post(
      '/api/v1/vocab',
      data: {
        'lemma': lemma,
        'display': display,
        'definition': definition,
        'ipa': ipa,
        'example': example,
      },
    );
  }

  Future<void> delete(int id) async {
    await _dio.delete('/api/v1/vocab/$id');
  }
}
