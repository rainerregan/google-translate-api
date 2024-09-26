# Google Translate Dart Package

This Dart package provides a simple interface to interact with the Google Translate API. It allows you to translate text between different languages, detect the language of a given text, and retrieve a list of supported languages.

## Features

- **Translate text**: Translate a given text from one language to another.
- **Detect language**: Automatically detect the language of the input text.
- **Supported languages**: Fetch a list of languages supported by Google Translate.

## Installation

1. Add the following dependency to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     google_translate:
       git:
         url: https://github.com/your-repository/google_translate.git
   ```

2. Run `flutter pub get` to install the dependencies.

## Usage

### 1. Import the package

```dart
import 'package:google_translate/google_translate.dart';
```

### 2. Initialize the GoogleTranslate instance

You need a Google Cloud API key to use the Google Translate API. You can create one [here](https://console.cloud.google.com/).

```dart
void main() {
  final googleTranslate = GoogleTranslate('YOUR_GOOGLE_API_KEY');
}
```

### 3. Translate text

You can translate text between different languages using the `translate` method. If the source language is unknown, the method will automatically detect the language.

```dart
void main() async {
  final googleTranslate = GoogleTranslate('YOUR_GOOGLE_API_KEY');

  // Translate from Spanish to English
  final translatedText = await googleTranslate.translate(
    text: 'Hola',
    targetLang: 'en',
  );
  print(translatedText); // Output: Hello
}
```

You can also specify the source language explicitly:

```dart
final translatedText = await googleTranslate.translate(
  text: 'Bonjour',
  sourceLang: 'fr',  // Specify the source language
  targetLang: 'en',
);
print(translatedText);  // Output: Hello
```

### 4. Detect the language of a text

You can detect the language of a given text using the `detectLanguage` method.

```dart
void main() async {
  final googleTranslate = GoogleTranslate('YOUR_GOOGLE_API_KEY');

  // Detect the language of the text
  final detectedLanguage = await googleTranslate.detectLanguage('Hola');
  print(detectedLanguage); // Output: es (Spanish)
}
```

### 5. Get the list of supported languages

You can retrieve the list of languages supported by Google Translate:

```dart
void main() async {
  final googleTranslate = GoogleTranslate('YOUR_GOOGLE_API_KEY');

  // Get the supported languages
  final languages = await googleTranslate.getSupportedLanguages();
  print(languages);  // Output: [en, es, fr, de, ...]
}
```

## Running Tests

To run the tests for this package, you can use the following command:

```bash
flutter test
```

The tests are written using the `test` and `mockito` packages to mock API responses.

### Example Test Case

```dart
test('should return translated text when source language is provided', () async {
  // Arrange: mock the API response
  final mockClient = MockClient();
  final googleTranslate = GoogleTranslate('FAKE_API_KEY');
  
  final response = jsonEncode({
    'data': {
      'translations': [
        {'translatedText': 'Hello'}
      ]
    }
  });
  
  when(mockClient.post(any, headers: anyNamed('headers')))
      .thenAnswer((_) async => http.Response(response, 200));

  // Act: call the translate function
  final translatedText = await googleTranslate.translate(
    text: 'Hola',
    sourceLang: 'es',
    targetLang: 'en',
  );

  // Assert: verify the result
  expect(translatedText, equals('Hello'));
});
```

## API Key Setup

To use this package, you need to enable the Google Cloud Translation API and generate an API key. Follow these steps:

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Select or create a new project.
3. Navigate to **API & Services > Library**.
4. Search for "Cloud Translation API" and enable it.
5. Navigate to **Credentials** and create a new API key.
6. Use the API key in your application.

## Contributing

Contributions are welcome! Feel free to submit a pull request or file an issue if you encounter any problems or have suggestions for improvements.

## License

This package is licensed under the MIT License. See the `LICENSE` file for more information.