import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class CommentInputField extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function() onSend; // <-- updated
  final bool isSending;

  const CommentInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isSending,
  });

  @override
  Widget build(BuildContext context) {
    return customMultipleTextField1(
      height: 50,
      hintText: 'Type your comments',
      hintFontWeight: FontWeight.w500,
      controller: controller,
      inputBgColor: Colors.white,
      hintFontColor: appGreyColor,
      hintFontSize: 16,
      contentPadding: const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
      suffixIcons: [
        MyInkWell(
          onTap: onSend, // now works as Future<void> Function()
          child: isSending
              ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2, color: buttonColor),
          )
              : Image.asset('assets/images/share_grey.png', height: 22, width: 22),
        ),
      ],
    );
  }
}

