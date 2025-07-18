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
          // Font Awesome icons with colored backgrounds and black outlines
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
                  child: Stack(
                    children: [
                      // Colored background
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Black icon for mouth/eyes
                      const Center(
                        child: FaIcon(
                          FontAwesomeIcons.faceFrown,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
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
                  child: Stack(
                    children: [
                      // Colored background
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Black icon for mouth/eyes
                      const Center(
                        child: FaIcon(
                          FontAwesomeIcons.faceFrownOpen,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
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
                  child: Stack(
                    children: [
                      // Colored background
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Black icon for mouth/eyes
                      const Center(
                        child: FaIcon(
                          FontAwesomeIcons.faceMeh,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
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
                  child: Stack(
                    children: [
                      // Colored background
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.lightGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Black icon for mouth/eyes
                      const Center(
                        child: FaIcon(
                          FontAwesomeIcons.faceSmile,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
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
                  child: Stack(
                    children: [
                      // Colored background
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Black icon for mouth/eyes
                      const Center(
                        child: FaIcon(
                          FontAwesomeIcons.faceSmileBeam,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
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
