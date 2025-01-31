import 'dart:async';
import 'package:flutter/material.dart';

dynamic onValue(val) {}

class CustomNavigator {
  static push({
    required BuildContext context,
    required Widget screen,
    FutureOr<dynamic> Function(dynamic) onCallback = onValue,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen)
    ).then(onCallback);
  }

  static pushReplacement({ 
    required BuildContext context,
    required Widget screen,
    FutureOr<dynamic> Function(dynamic) onCallback = onValue,
  }) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen)
    ).then(onCallback);
  }

  static pushAndRemoveUntil({
    required BuildContext context,
    required Widget screen
  }) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => screen),
            (route) => false);
  }

  static pop({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}

enum NavigationType { forgotPassword, signup, signIn }



