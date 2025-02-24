import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool isRecording = false;
  bool isFlashOn = false;
  int selectedCameraIndex = 0;
  File? _videoFile;
  VideoPlayerController? _videoPlayerController;
  int countdown = 3;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras[selectedCameraIndex], ResolutionPreset.high);
      await _controller.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    }
  }

  void _switchCamera() async {
    selectedCameraIndex = (selectedCameraIndex + 1) % _cameras.length;
    await _initCameras();
  }

  void _toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      _controller.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  Future<void> _startRecording() async {
    final directory = await getTemporaryDirectory();
    final videoPath = '${directory.path}/${DateTime.now()}.mp4';

    await _controller.startVideoRecording();
    setState(() => isRecording = true);

    Future.delayed(const Duration(seconds: 10), () async {
      await _stopRecording();
    });
  }

  Future<void> _stopRecording() async {
    final video = await _controller.stopVideoRecording();
    setState(() {
      isRecording = false;
      _videoFile = File(video.path);
      _videoPlayerController = VideoPlayerController.file(_videoFile!)
        ..initialize()
        ..setLooping(true)
        ..play();
    });
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _videoPlayerController = VideoPlayerController.file(_videoFile!)
          ..initialize()
          ..setLooping(true)
          ..play();
      });
    }
  }

  Future<void> _startCountdown() async {
    for (int i = countdown; i > 0; i--) {
      setState(() => countdown = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    _startRecording();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (!isCameraInitialized)
            const Center(child: CircularProgressIndicator())
          else if (_videoFile == null)
            CameraPreview(_controller)
          else if (_videoPlayerController!.value.isInitialized)
              Center(
                child: AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                ),
              ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 30),
              onPressed: _switchCamera,
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white, size: 30),
              onPressed: _toggleFlash,
            ),
          ),
          Positioned(
            bottom: 80,
            left: 50,
            child: IconButton(
              icon: const Icon(Icons.video_library, color: Colors.white, size: 35),
              onPressed: _pickVideo,
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: GestureDetector(
              onTap: isRecording ? _stopRecording : _startCountdown,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: isRecording ? Colors.red : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          if (!isRecording && _videoFile != null)
            Positioned(
              bottom: 80,
              right: 50,
              child: IconButton(
                icon: const Icon(Icons.replay, color: Colors.white, size: 35),
                onPressed: () {
                  _videoPlayerController?.seekTo(Duration.zero);
                  _videoPlayerController?.play();
                },
              ),
            ),
        ],
      ),
    );
  }
}
