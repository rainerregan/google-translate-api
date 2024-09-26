import 'package:google_translate_api/google_translate_api.dart';

void main() async {
  final googleTranslate = GoogleTranslate('YOUR_GOOGLE_API_KEY');

  // Example: Translate 'Hello' from English to Spanish
  final translatedText = await googleTranslate.translate(
    text: 'Hello',
    targetLang: 'es',
  );
  print('Translated text: $translatedText'); // Output: Hola

  // Example: Detect the language of a text
  final detectedLang = await googleTranslate.detectLanguage('Bonjour');
  print('Detected language: $detectedLang'); // Output: fr

  // Example: Get a list of supported languages
  final supportedLanguages = await googleTranslate.getSupportedLanguages();
  print('Supported languages: $supportedLanguages');
}
