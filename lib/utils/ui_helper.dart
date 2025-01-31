import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiHelper {
  ///https://api.flutter.dev/flutter/material/TextTheme-class.html
  ///Flutter default text size
  ///   NAME	         SIZE	    WEIGHT	    SPACING     DEPRECATED NAME
  ///   displayLarge	 96.0	     light	    -1.5         headline1
  ///   displayMedium	 60.0	     light	    -0.5         headline2
  ///   displaySmall   48.0	     regular	   0.0         headline3
  ///   headlineMedium 34.0	     regular	   0.25        headline4
  ///   headlineSmall	 24.0	     regular	   0.0         headline5
  ///   titleLarge	   20.0	     medium	     0.15        headline6
  ///   titleMedium	   16.0	     regular	   0.15        subtitle1
  ///   titleSmall	   14.0	     medium	     0.1         subtitle2
  ///   bodyLarge	     16.0	     regular	   0.5	       (bodyText1)
  ///   bodyMedium     14.0	     regular	   0.25	       (bodyText2)
  ///   labelLarge	   14.0	     medium	     1.25        (button)  (Used for text on ElevatedButton, TextButton and OutlinedButton.)
  ///   bodySmall	     12.0	     regular     0.4         (caption)
  ///   labelSmall	   10.0	     regular     1.5          overline


  static Widget verticalSpace({double height = 16}) =>
      SizedBox(
        height: height,
      );

  static Widget horizontalSpace({double width = 8}) =>
      SizedBox(
        width: width,
      );
  static toastMessage(String msg,
      {ToastGravity? toastGravity = ToastGravity.BOTTOM,
        Toast toastLength = Toast.LENGTH_LONG, // Set to LENGTH_LONG for longer duration
        int timeInSecForIosWeb = 3}) {
    // Increase the duration for iOS/web
    Fluttertoast.cancel(); // Cancel any existing toast first
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: toastGravity ?? ToastGravity.CENTER,
      timeInSecForIosWeb: timeInSecForIosWeb,
      // Set the duration
      textColor: Colors.white,
      backgroundColor: Colors.black,
      // backgroundColor: const Color(0xffFF0235),
      fontSize: 16.0,
    );
  }









}
