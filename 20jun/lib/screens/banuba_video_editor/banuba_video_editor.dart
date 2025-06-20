// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tictoc/screens/video_editor/audio_browser.dart';
// import 'package:tictoc/screens/video_editor/upload_video.dart';
//
//
// class BanubaVideoEditor extends StatefulWidget {
//   const BanubaVideoEditor({super.key});
//
//   @override
//   State<BanubaVideoEditor> createState() => _BanubaVideoEditorState();
// }
//
// class _BanubaVideoEditorState extends State<BanubaVideoEditor> {
//   // Set Banuba license token for Video and Photo Editor SDK
//   static const String LICENSE_TOKEN = "Qk5CIJS2PUkB9rZUCe5w7CbNQ7PFb3odz/94gxuR4FWtjynqx1U0TJqLtsbPN44CGCjsNP6cWSIXzDxpFJe12SSzzprQiPdmR45TnofaI3Efn1dZ/i4kHuFux/1dXEB1qKLCZtBPhsFmnIXqAlOBecwnu4FMucYs+1KCESmsZjQPPh1xLvIUMZBZrV2ug+u08Zk0Wj3pBco4cqmHDrH8zM2NEK/VoOw/5VYJUD0Qe2fRJxeOPKNmgfsZwfOO7UVSRSFPqnlrt9YzteuSrWPvw4FFZALWuwYrs61bTo7akocu96hq0PdmnSgRE4h5UcsbAQEdelzzC8LxQoiU6kHGpsM+0+igrPkMgy2w5bhNQXQrfyzVhONY0jdJ5i11rRU8vqfn75Lxgg1pUGU9uX8/jLvYcQceqen6DFtO1uuEBvJ3wASsGV21t9rdJ4qHpCcp9zItWjDxvUAyZexkJ01ES7j5FUspfNjE9Dxrj34CJhx7LwxStEyM8SfxgqcmBCp4MFA12pXyhZlqlrLoEibVNGhvEdYq7s/9Ek7TRay7g9h/IHneCGA0g5x9ntg6yRLjDBEOi7yu8HdleJ8LgXBXJpuBnVMB1utx6fxGsRswcTUTBJbhYIK3gAmNBDqTD64PORcwPfUjpikW9JEAy8hMaOc=";
//
//   // For Video Editor
//   static const methodInitVideoEditor = 'initVideoEditor';
//   static const methodStartVideoEditor = 'startVideoEditor';
//   static const methodStartVideoEditorPIP = 'startVideoEditorPIP';
//   static const methodStartVideoEditorTrimmer = 'startVideoEditorTrimmer';
//   static const methodReleaseVideoEditor = 'releaseVideoEditor';
//   static const methodDemoPlayExportedVideo = 'playExportedVideo';
//
//   static const argExportedVideoFile = 'argExportedVideoFilePath';
//   static const argExportedVideoCoverPreviewPath = 'argExportedVideoCoverPreviewPath';
//
//   // For Photo Editor
//   static const methodInitPhotoEditor = 'initPhotoEditor';
//   static const methodStartPhotoEditor = 'startPhotoEditor';
//   static const argExportedPhotoFile = 'argExportedPhotoFilePath';
//
//   static const platformChannel = MethodChannel('banubaSdkChannel');
//
//   String _errorMessage = '';
//
//   Future<void> _initPhotoEditor() async {
//     if (Platform.isAndroid){
//       await _releaseVideoEditor();
//     }
//     await platformChannel.invokeMethod(methodInitPhotoEditor, LICENSE_TOKEN);
//   }
//
//
//
//   Future<void> _initVideoEditor() async {
//     await platformChannel.invokeMethod(methodInitVideoEditor, LICENSE_TOKEN);
//   }
//
//   Future<void> _startVideoEditorDefault() async {
//     try {
//       await _initVideoEditor();
//
//       final result = await platformChannel.invokeMethod(methodStartVideoEditor);
//
//       _handleVideoEditorResult(result);
//     } on PlatformException catch (e) {
//       _handlePlatformException(e);
//     }
//   }
//
//   Future<void> _releaseVideoEditor() async {
//     try {
//       await platformChannel.invokeMethod(methodReleaseVideoEditor);
//     } on PlatformException catch (e) {
//       _handlePlatformException(e);
//     }
//   }
//
//   // Handle exceptions thrown on Android, iOS platform while starting Video and Photo Editor SDK
//   void _handlePlatformException(PlatformException exception) {
//     debugPrint("Error: '${exception.message}'.");
//
//     String errorMessage = '';
//     switch (exception.code) {
//       case 'ERR_SDK_LICENSE_REVOKED':
//         errorMessage =
//         'The license is revoked or expired. Please contact Banuba https://www.banuba.com/support';
//         break;
//       case 'ERR_SDK_NOT_INITIALIZED':
//         errorMessage =
//         'Banuba Video and Photo Editor SDK is not initialized: license token is unknown or incorrect.\nPlease check your license token or contact Banuba';
//         break;
//       case 'ERR_MISSING_EXPORT_RESULT':
//         errorMessage = 'Missing video export result!';
//         break;
//       case 'ERR_START_PIP_MISSING_VIDEO':
//         errorMessage = 'Cannot start video editor in PIP mode: passed video is missing or invalid';
//         break;
//       case 'ERR_START_TRIMMER_MISSING_VIDEO':
//         errorMessage = 'Cannot start video editor in trimmer mode: passed video is missing or invalid';
//         break;
//       case 'ERR_EXPORT_PLAY_MISSING_VIDEO':
//         errorMessage = 'Missing video file to play';
//         break;
//       default:
//         errorMessage = 'unknown error';
//     }
//
//     _errorMessage = errorMessage;
//     setState(() {});
//   }
//
//   void _handleVideoEditorResult(dynamic result) {
//     debugPrint('Received Video Editor result');
//
//     if (result is Map) {
//       final exportedVideoFilePath = result[argExportedVideoFile];
//
//       debugPrint('Exported video = $exportedVideoFilePath');
//
//       // Navigate to UploadVideo screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => UploadVideo(videoFile: File(exportedVideoFilePath)),
//         ),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('widget.title'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(15.0),
//                     child: Text(
//                       _errorMessage,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.blueAccent,
//                       shadowColor: Colors.blueGrey,
//                       elevation: 10,
//                       fixedSize: const Size(280, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     onPressed: () => _startVideoEditorDefault(),
//                     child: const Text(
//                       'Open Video Editor - Default',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
