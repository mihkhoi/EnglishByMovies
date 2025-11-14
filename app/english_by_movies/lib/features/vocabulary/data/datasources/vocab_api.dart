import 'package:english_by_movies/app/env.dart'; // thay tên gói đúng với pubspec_name
import 'package:dio/dio.dart';

class VocabApi {
  final Dio _dio = Dio(BaseOptions(baseUrl: Env.apiBaseUrl));

  Future<List<Map<String, dynamic>>> list() async {
    final res = await _dio.get('/api/v1/vocab');
    return (res.data as List).cast<Map<String, dynamic>>();
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
