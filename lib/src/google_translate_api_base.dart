import 'dart:convert';
import 'package:http/http.dart' as http;

/// A library to interact with Google Translate API
class GoogleTranslate {
  final String _apiKey;

  GoogleTranslate(this._apiKey);

  /// Translate a given [text] from [sourceLang] (optional) to [targetLang].
  /// If [sourceLang] is not provided, the function will detect the language.
  Future<String> translate({
    required String text,
    String? sourceLang,
    required String targetLang,
  }) async {
    // If the source language is not provided, detect it
    sourceLang ??= await detectLanguage(text);

    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$_apiKey');

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'source': sourceLang,
          'target': targetLang,
          'format': 'text',
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final translatedText = data['data']['translations'][0]['translatedText'];
      return translatedText;
    } else {
      throw Exception('Failed to translate text: ${response.body}');
    }
  }

  /// Detect the language of the given [text].
  Future<String> detectLanguage(String text) async {
    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2/detect?key=$_apiKey');

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final detectedLanguage = data['data']['detections'][0][0]['language'];
      return detectedLanguage;
    } else {
      throw Exception('Failed to detect language: ${response.body}');
    }
  }

  /// Get a list of supported languages.
  Future<List<String>> getSupportedLanguages() async {
    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2/languages?key=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final languages = data['data']['languages'].map<String>((lang) => lang['language'] as String).toList();
      return languages;
    } else {
      throw Exception('Failed to fetch supported languages: ${response.body}');
    }
  }
}
