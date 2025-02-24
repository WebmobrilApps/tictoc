import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


class VideoFilterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Filter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoHomePage(),
    );
  }
}

class VideoHomePage extends StatefulWidget {
  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  VideoPlayerController? _controller;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _initializeVideoPlayer(pickedFile.path);
    }
  }

  Future<void> _captureVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      _initializeVideoPlayer(pickedFile.path);
    }
  }

  void _initializeVideoPlayer(String path) {
    if (_controller != null) {
      _controller!.dispose();
    }
    _controller = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Filter App'),
      ),
      body: Center(
        child: _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        )
            : Text('No video selected.'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pickVideo,
            tooltip: 'Pick Video',
            child: Icon(Icons.video_library),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _captureVideo,
            tooltip: 'Capture Video',
            child: Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}