// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';
//
//
// class VideoRecorderScreen extends StatefulWidget {
//   const VideoRecorderScreen({Key? key}) : super(key: key);
//
//   @override
//   _VideoRecorderScreenState createState() => _VideoRecorderScreenState();
// }
//
// class _VideoRecorderScreenState extends State<VideoRecorderScreen> {
//   CameraController? _controller;
//   bool _isRecording = false;
//   XFile? _videoFile;
//   String? _filteredVideoPath;
//   VideoPlayerController? _videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     _controller = CameraController(cameras.first, ResolutionPreset.high);
//     await _controller?.initialize();
//     if (mounted) setState(() {});
//   }
//
//   Future<void> _startRecording() async {
//     if (_controller == null || !_controller!.value.isInitialized) return;
//
//     await _controller?.startVideoRecording();
//     setState(() => _isRecording = true);
//   }
//
//   Future<void> _stopRecording() async {
//     if (_controller == null || !_controller!.value.isRecordingVideo) return;
//
//     XFile video = await _controller!.stopVideoRecording();
//     setState(() {
//       _isRecording = false;
//       _videoFile = video;
//       _filteredVideoPath = null;
//     });
//
//     _playVideo(video.path);
//   }
//
//   void _playVideo(String path) {
//     _videoPlayerController?.dispose();
//     _videoPlayerController = VideoPlayerController.file(File(path))
//       ..initialize().then((_) {
//         setState(() {});
//         _videoPlayerController?.play();
//       });
//   }
//
//   Future<void> _applyFilter(String filterType) async {
//     if (_videoFile == null) return;
//
//     String inputPath = _videoFile!.path;
//     Directory tempDir = await getTemporaryDirectory();
//     String outputPath = "${tempDir.path}/filtered_video.mp4";
//
//     String filterCommand = "";
//     if (filterType == "Grayscale") {
//       filterCommand = "-vf format=gray";
//     } else if (filterType == "Sepia") {
//       filterCommand = "-vf colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131";
//     } else if (filterType == "Invert") {
//       filterCommand = "-vf negate";
//     }
//
//     await FFmpegKit.execute("-i $inputPath $filterCommand $outputPath");
//
//     setState(() {
//       _filteredVideoPath = outputPath;
//     });
//
//     _playVideo(outputPath);
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     _videoPlayerController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(title: const Text("TikTok-Style Video Recorder"), backgroundColor: Colors.black),
//       body: Column(
//         children: [
//           Expanded(
//             child: _controller == null || !_controller!.value.isInitialized
//                 ? const Center(child: CircularProgressIndicator())
//                 : CameraPreview(_controller!),
//           ),
//           if (_videoFile != null || _filteredVideoPath != null)
//             Container(
//               height: 250,
//               color: Colors.black,
//               child: _videoPlayerController != null && _videoPlayerController!.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _videoPlayerController!.value.aspectRatio,
//                 child: VideoPlayer(_videoPlayerController!),
//               )
//                   : const Center(child: CircularProgressIndicator()),
//             ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FloatingActionButton(
//                 onPressed: _isRecording ? _stopRecording : _startRecording,
//                 child: Icon(_isRecording ? Icons.stop : Icons.videocam),
//               ),
//               const SizedBox(width: 10),
//               if (_videoFile != null)
//                 FloatingActionButton.extended(
//                   onPressed: () => _applyFilter("Grayscale"),
//                   label: const Text("Grayscale"),
//                 ),
//               if (_videoFile != null)
//                 FloatingActionButton.extended(
//                   onPressed: () => _applyFilter("Sepia"),
//                   label: const Text("Sepia"),
//                 ),
//               if (_videoFile != null)
//                 FloatingActionButton.extended(
//                   onPressed: () => _applyFilter("Invert"),
//                   label: const Text("Invert"),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
