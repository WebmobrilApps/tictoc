import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tictoc/screens/banuba_video_editor/upload_video.dart';

class BanubaVideoEditorHelper {
  // Set Banuba license token for Video and Photo Editor SDK
 // static const String LICENSE_TOKEN = "Qk5CIJS2PUkB9rZUCe5w7CbNQ7PFb3odz/94gxuR4FWtjynqx1U0TJqLtsbPN44CGCjsNP6cWSIXzDxpFJe12SSzzprQiPdmR45TnofaI3Efn1dZ/i4kHuFux/1dXEB1qKLCZtBPhsFmnIXqAlOBecwnu4FMucYs+1KCESmsZjQPPh1xLvIUMZBZrV2ug+u08Zk0Wj3pBco4cqmHDrH8zM2NEK/VoOw/5VYJUD0Qe2fRJxeOPKNmgfsZwfOO7UVSRSFPqnlrt9YzteuSrWPvw4FFZALWuwYrs61bTo7akocu96hq0PdmnSgRE4h5UcsbAQEdelzzC8LxQoiU6kHGpsM+0+igrPkMgy2w5bhNQXQrfyzVhONY0jdJ5i11rRU8vqfn75Lxgg1pUGU9uX8/jLvYcQceqen6DFtO1uuEBvJ3wASsGV21t9rdJ4qHpCcp9zItWjDxvUAyZexkJ01ES7j5FUspfNjE9Dxrj34CJhx7LwxStEyM8SfxgqcmBCp4MFA12pXyhZlqlrLoEibVNGhvEdYq7s/9Ek7TRay7g9h/IHneCGA0g5x9ntg6yRLjDBEOi7yu8HdleJ8LgXBXJpuBnVMB1utx6fxGsRswcTUTBJbhYIK3gAmNBDqTD64PORcwPfUjpikW9JEAy8hMaOc=";
  static const String LICENSE_TOKEN = "Qk5CIJP43tBteEM4fx7BNN6JEVVFSVg/0ddH1usD7Jhb85VRf2AbU+2Dj+0c3tB4BcVzZtIuyfCIeWHF+M1wF9E4UlSwih6mJGkRZ71XSVKUwVDv+irQs+UHtDvAYupBcwNcMYVm2W4ZLKpVxholCsAnpJsf0U3arzF10U1YhbsqAxe4EJQ0tkqWDsrMyl20+0JqZUZRC7+a7mb++3fbxS03lX42/0gr3j/3eZ3P2E8Atp2ewmr/99mKAx1sO7RKtr6K6c9tMJCdkPXE4PqHVemazOc7w0Xf+6QyJ0L/tuudhuq1Pek6ThcPqgG5XjUn1QGV5M8JBYqerchUbUkLFgD4keK+tzYVhK/tM4p1wFAgDym2OtVeBaEDDohbAIJ/8NxMAqD6sarmnbPZZYUgrSVDssRjO9TgF5oqhmLcw44IsENLzWpHAb2pLPUbjdgQwNbpwj5r6myR/qeUkDoN6lSopCwEbckKazWsei6U2xIg7XOuXllHlAoq1inq4n0ZcfZNJeInu+kA9ffZpwQ2uy4+d3Eo3GQ9sAHPd5rhzPskpWcQAJPB5qbs3mJNp5Ih/c7QqNBODsoU8PKzbcTZ82KZG6d0HSHXnjIFqgD8MwkdsZ2RylVB29W8sWHVw4gT161+NENzd7NSpchoIbr6XuA=";

  // For Video Editor
  static const methodInitVideoEditor = 'initVideoEditor';
  static const methodStartVideoEditor = 'startVideoEditor';
  static const methodStartVideoEditorPIP = 'startVideoEditorPIP';
  static const methodStartVideoEditorTrimmer = 'startVideoEditorTrimmer';
  static const methodReleaseVideoEditor = 'releaseVideoEditor';
  static const methodDemoPlayExportedVideo = 'playExportedVideo';

  static const argExportedVideoFile = 'argExportedVideoFilePath';
  static const argExportedVideoCoverPreviewPath = 'argExportedVideoCoverPreviewPath';

  // For Photo Editor
  static const methodInitPhotoEditor = 'initPhotoEditor';
  static const methodStartPhotoEditor = 'startPhotoEditor';
  static const argExportedPhotoFile = 'argExportedPhotoFilePath';

  static const platformChannel = MethodChannel('banubaSdkChannel');

  String _errorMessage = '';

  static Future<void> startVideoEditor(BuildContext context,PersistentTabController controller) async {
    try {
      await _initVideoEditor();

      final result = await platformChannel.invokeMethod(methodStartVideoEditor);

      _handleVideoEditorResult(context, result,controller);
    } on PlatformException catch (e) {
      _handlePlatformException(context, e);
    }
  }

  static Future<void> _initVideoEditor() async {
    await platformChannel.invokeMethod(methodInitVideoEditor, LICENSE_TOKEN);
  }

  static Future<void> releaseVideoEditor() async {
    try {
      await platformChannel.invokeMethod(methodReleaseVideoEditor);
    } on PlatformException catch (e) {
      debugPrint("Error releasing Banuba SDK: ${e.message}");
    }
  }

  static void _handlePlatformException(BuildContext context, PlatformException exception) {
    debugPrint("Error: '${exception.message}'.");

    String errorMessage;
    switch (exception.code) {
      case 'ERR_SDK_LICENSE_REVOKED':
        errorMessage = 'License revoked. Contact Banuba support.';
        break;
      case 'ERR_SDK_NOT_INITIALIZED':
        errorMessage = 'SDK not initialized. Check license token.';
        break;
      case 'ERR_MISSING_EXPORT_RESULT':
        errorMessage = 'Missing video export result!';
        break;
      default:
        errorMessage = 'Unknown error occurred.';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  static void _handleVideoEditorResult(BuildContext context, dynamic result,PersistentTabController controller) {
    if (result is Map && result.containsKey(argExportedVideoFile)) {
      String exportedVideoFilePath = result[argExportedVideoFile];
      if (exportedVideoFilePath.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadVideo(videoFile: File(exportedVideoFilePath),controller: controller,),
          ),
        );
      }
    }
  }
}
