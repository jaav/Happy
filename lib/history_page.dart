import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<MoodRecord> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  // Load records from the service
  Future<void> _loadRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final records = await MoodRecordService.getAllMoodRecords();
      // Sort records by timestamp (newest first)
      records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      setState(() {
        _records = records;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading records: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Get the appropriate icon for the emoticon value
  IconData _getEmoticonIcon(int emoticon) {
    switch (emoticon) {
      case 1:
        return FontAwesomeIcons.faceFrown;
      case 2:
        return FontAwesomeIcons.faceFrownOpen;
      case 3:
        return FontAwesomeIcons.faceMeh;
      case 4:
        return FontAwesomeIcons.faceSmile;
      case 5:
        return FontAwesomeIcons.faceSmileBeam;
      default:
        return FontAwesomeIcons.faceMeh;
    }
  }

  // Get the appropriate color for the emoticon value
  Color _getEmoticonColor(int emoticon) {
    switch (emoticon) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.yellow;
    }
  }

  // Format the timestamp
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final recordDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (recordDate == today) {
      return 'Today, ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (recordDate == yesterday) {
      return 'Yesterday, ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}, ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the current index to 1 for the History tab
    BottomNavBar.currentIndex = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood History'),
      ),
      bottomNavigationBar: BottomNavBar.build(context),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _records.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.clockRotateLeft,
                        size: 50,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No mood records yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your saved moods will appear here',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(title: ''),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Record Your Mood'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadRecords,
                  child: ListView.builder(
                    itemCount: _records.length,
                    itemBuilder: (context, index) {
                      final record = _records[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            child: Stack(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getEmoticonColor(record.emoticon),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Center(
                                  child: FaIcon(
                                    _getEmoticonIcon(record.emoticon),
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                            record.text.isEmpty ? 'No comment' : record.text,
                            style: TextStyle(
                              fontStyle: record.text.isEmpty
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              color: record.text.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          subtitle: Text(_formatTimestamp(record.timestamp)),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}