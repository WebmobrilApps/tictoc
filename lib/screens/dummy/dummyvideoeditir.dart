import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoEditorUI extends StatefulWidget {
  @override
  _VideoEditorUIState createState() => _VideoEditorUIState();
}

class _VideoEditorUIState extends State<VideoEditorUI> {
  bool isRecording = false;
  int recordingDuration = 15;
  bool isMicEnabled = true;

  List<String> soundList = ['Sound 1', 'Sound 2', 'Sound 3'];

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });
    print(isRecording ? "Recording started" : "Recording stopped");
  }

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      print('Video selected: ${video.path}');
    } else {
      print('No video selected');
    }
  }

  void _showSoundBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: soundList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.music_note, color: Colors.white),
                title: Text(soundList[index], style: TextStyle(color: Colors.white)),
                onTap: () {
                  print('Selected sound: ${soundList[index]}');
                },
              );
            },
          ),
        );
      },
    );
  }

  String _getCurrentDate() {
    final DateTime now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.grey,)
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.flip),
                  onPressed: () => print('Flip camera'),
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    setState(() {
                      isMicEnabled = !isMicEnabled;
                    });
                    print('Mic: $isMicEnabled');
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      recordingDuration = recordingDuration == 15 ? 60 : 15;
                    });
                  },
                  child: Text('$recordingDuration s'),
                ),
                IconButton(
                  icon: Icon(isRecording ? Icons.stop : Icons.circle, size: 70),
                  onPressed: _toggleRecording,
                ),
              ],
            ),
          ),
          const Positioned(
            top: 20,
            left: 20,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Text('R'),
            ),
          ),
        ],
      ),
    );
  }
}

