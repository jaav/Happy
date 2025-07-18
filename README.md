# Happy2 Application

This application displays a question "How are you doing today?" and provides emoticon options for the user to select their mood.

## Font Awesome Implementation

The application is currently using Material Icons for the emoticons, but the requirement is to use Font Awesome icons instead. To implement this:

1. Make sure the `font_awesome_flutter` package is added to your `pubspec.yaml` file:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     flutter_localizations:
       sdk: flutter
     intl: ^0.20.2
     font_awesome_flutter: ^10.6.0
   ```

2. Run the following command to install the package:
   ```
   flutter pub get
   ```

3. Update the `main.dart` file to use Font Awesome icons:
   - Import the package: `import 'package:font_awesome_flutter/font_awesome_flutter.dart';`
   - Replace the Material Icons with Font Awesome icons:

```dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Simple translations class that can be expanded later for proper localization
class AppTranslations {
  static String get howAreYouTitle => 'How are you doing today?';
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Text(
            AppTranslations.howAreYouTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Very unhappy face - red
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  child: const FaIcon(
                    FontAwesomeIcons.faceFrown,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              // Unhappy face - orange
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  child: const FaIcon(
                    FontAwesomeIcons.faceFrownOpen,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
              ),
              // Neutral face - yellow
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  child: const FaIcon(
                    FontAwesomeIcons.faceMeh,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ),
              ),
              // Happy face - light green
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  child: const FaIcon(
                    FontAwesomeIcons.faceSmile,
                    color: Colors.lightGreen,
                    size: 40,
                  ),
                ),
              ),
              // Very happy face - green
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  child: const FaIcon(
                    FontAwesomeIcons.faceSmileBeam,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
```

## Current Implementation

The current implementation uses Material Icons as a temporary solution until the Font Awesome package can be properly installed. The Material Icons used are:

- Very unhappy: `Icons.sentiment_very_dissatisfied` (red)
- Unhappy: `Icons.sentiment_dissatisfied` (orange)
- Neutral: `Icons.sentiment_neutral` (yellow)
- Happy: `Icons.sentiment_satisfied` (light green)
- Very happy: `Icons.sentiment_very_satisfied` (green)

To switch to Font Awesome icons, follow the steps above.