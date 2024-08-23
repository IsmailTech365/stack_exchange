import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_exchange/core/constants/app_constant.dart';
import '../controllers/question_controller.dart';
import 'detail_view.dart';

class HomeView extends StatelessWidget {
  final QuestionController controller = Get.put(QuestionController());
  final ScrollController _scrollController = ScrollController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image.asset(
            AppImages.logo,
            height: 70,
          ),
        ),
        elevation: 5, // Adds a shadow for depth
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.questions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: controller.questions.length +
              (controller.isLoading.value ? 1 : 0),
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            if (index == controller.questions.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final question = controller.questions[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: Icon(
                  question.isAnswered ? Icons.check_circle : Icons.help_outline,
                  color: question.isAnswered ? Colors.green : Colors.red,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onTap: () {
                  Get.to(() => DetailView(question: question));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
