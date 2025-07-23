import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:collection';
import 'history_page.dart';

// Simple translations class that can be expanded later for proper localization
class AppTranslations {
  static String get howAreYouTitle => 'How are you doing today?';
  static String get whyAreYouTitle => 'Why are you ...';
  static String get today => 'Today';
  static String get history => 'History';
  static String get settings => 'Settings';
}

// Emoticon data class to pass between pages
class EmoticonData {
  final IconData icon;
  final Color color;

  const EmoticonData({
    required this.icon,
    required this.color,
  });

  // Get the emoticon value (1-5) based on the icon
  int get value {
    if (icon == FontAwesomeIcons.faceFrown) return 1;
    if (icon == FontAwesomeIcons.faceFrownOpen) return 2;
    if (icon == FontAwesomeIcons.faceMeh) return 3;
    if (icon == FontAwesomeIcons.faceSmile) return 4;
    if (icon == FontAwesomeIcons.faceSmileBeam) return 5;
    return 3; // Default to neutral if unknown
  }
}

// Model class for storing mood records
class MoodRecord {
  final int emoticon; // 1-5 representing the emoticon
  final String text; // User entered text (can be blank)
  final DateTime timestamp; // When the record was created

  MoodRecord({
    required this.emoticon,
    required this.text,
    required this.timestamp,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'emoticon': emoticon,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  // Create from JSON for retrieval
  factory MoodRecord.fromJson(Map<String, dynamic> json) {
    return MoodRecord(
      emoticon: json['emoticon'],
      text: json['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }
}

// Simple service class for storing and retrieving mood records
class MoodRecordService {
  // In-memory storage
  static final List<MoodRecord> _records = [];

  // Save a record
  static Future<bool> saveMoodRecord(MoodRecord record) async {
    _records.add(record);
    return true;
  }

  // Get all records
  static Future<List<MoodRecord>> getAllMoodRecords() async {
    return _records;
  }

  // Clear all records
  static Future<bool> clearAllRecords() async {
    _records.clear();
    return true;
  }
}

// Bottom navigation bar utility class
class BottomNavBar {
  static int currentIndex = 0;

  static Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.calendarDay),
          label: AppTranslations.today,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
          label: AppTranslations.history,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.gear),
          label: AppTranslations.settings,
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        currentIndex = index;

        // Navigate to the appropriate page based on the index
        if (index == 0) {
          if (!(context.widget is MyHomePage)) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: '')),
              (route) => false,
            );
          }
        } else if (index == 1) {
          // Navigate to History page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryPage()),
          );
        } else if (index == 2) {
          // Navigate to Settings page (placeholder for now)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Settings page not implemented yet')),
          );
        }
      },
    );
  }
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
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(title: ''),
    const HistoryPage(),
    const Center(child: Text('Settings Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.calendarDay),
          label: AppTranslations.today,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
          label: AppTranslations.history,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.gear),
          label: AppTranslations.settings,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}

class EmoticonDetailPage extends StatefulWidget {
  final EmoticonData emoticonData;
  final VoidCallback? onBack;

  const EmoticonDetailPage({
    super.key,
    required this.emoticonData,
    this.onBack,
  });

  @override
  State<EmoticonDetailPage> createState() => _EmoticonDetailPageState();
}

class _EmoticonDetailPageState extends State<EmoticonDetailPage> {
  // Controller for the text field
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate 25% of the device width
    final emoticonSize = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      bottomNavigationBar: BottomNavBar.build(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Position the title at 1/5 of the screen height from the top
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Text(
              AppTranslations.whyAreYouTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Display the selected emoticon at 25% of the device width
            Center(
              child: Container(
                width: emoticonSize,
                height: emoticonSize,
                child: Stack(
                  children: [
                    // Colored background
                    Container(
                      width: emoticonSize,
                      height: emoticonSize,
                      decoration: BoxDecoration(
                        color: widget.emoticonData.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Black icon for mouth/eyes
                    Center(
                      child: FaIcon(
                        widget.emoticonData.icon,
                        color: Colors.black,
                        size: emoticonSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Text field for user input
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your thoughts...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            // Green check icon with "Save" text
            InkWell(
              onTap: () async {
                // Get the text (can be empty)
                final text = _textController.text;

                // Create a new mood record
                final record = MoodRecord(
                  emoticon: widget.emoticonData.value,
                  text: text, // Can be empty
                  timestamp: DateTime.now(),
                );

                // Save the record
                final success = await MoodRecordService.saveMoodRecord(record);

                if (success) {
                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Record saved successfully')),
                  );
                  // Clear the text field
                  _textController.clear();
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to save record')),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.check,
                      color: Colors.green,
                      size: 24,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Set the current index to 0 for the Today tab
    BottomNavBar.currentIndex = 0;

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmoticonDetailPage(
                        emoticonData: const EmoticonData(
                          icon: FontAwesomeIcons.faceFrown,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmoticonDetailPage(
                        emoticonData: const EmoticonData(
                          icon: FontAwesomeIcons.faceFrownOpen,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmoticonDetailPage(
                        emoticonData: const EmoticonData(
                          icon: FontAwesomeIcons.faceMeh,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmoticonDetailPage(
                        emoticonData: const EmoticonData(
                          icon: FontAwesomeIcons.faceSmile,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmoticonDetailPage(
                        emoticonData: const EmoticonData(
                          icon: FontAwesomeIcons.faceSmileBeam,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
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
