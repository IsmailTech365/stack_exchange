import 'package:get/get.dart';
import '../models/questions.dart';
import '../core/services/api_service.dart';
import '../core/services/db_service.dart';

class QuestionController extends GetxController {
  var questions = <Question>[].obs;
  var isLoading = true.obs;
  final ApiService _apiService = ApiService();
  final DBService _dbService = DBService();
  final int _page = 10;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    isLoading(true);
    try {
      final fetchedQuestions = await _apiService.fetchQuestions(page: _page);
      questions.addAll(fetchedQuestions);
      for (var question in fetchedQuestions) {
        await _dbService.insertQuestion(question);
      }
    } catch (e) {
      final offlineQuestions = await _dbService.getQuestions();
      questions.assignAll(offlineQuestions);
    } finally {
      isLoading(false);
    }
  }
}
