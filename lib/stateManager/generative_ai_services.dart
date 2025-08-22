import 'package:firebase_ai/firebase_ai.dart';

class GenerativeAi {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  Future<String> generateNote({required String textPrompt}) async {
    final prompt = [Content.text(textPrompt)];

    final response = await model.generateContent(prompt);

    return response.text ?? "Text not generated";
  }
}
