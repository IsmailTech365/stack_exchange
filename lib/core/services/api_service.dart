import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/questions.dart';

class ApiService {
  final String baseUrl = 'https://api.stackexchange.com/2.3';

  Future<List<Question>> fetchQuestions({int page = 1}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/questions?page=$page&pagesize=10&order=desc&sort=activity&site=stackoverflow'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final questions = (data['items'] as List)
          .map((json) => Question.fromJson(json))
          .toList();
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
