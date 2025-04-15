import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_widgets.dart';

class FriendsSearchBar extends StatefulWidget {
  final TextEditingController commentController;
  final Future<void> Function() onClear; // <-- Change this

  const FriendsSearchBar({super.key, required this.commentController, required this.onClear});

  @override
  State<FriendsSearchBar> createState() => _FriendsSearchBarState();
}

class _FriendsSearchBarState extends State<FriendsSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.commentController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.commentController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // Triggers a rebuild when the text changes
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: customTextFieldWithBorder(
            height: 42,
            hintText: 'Find Friends',
            controller: widget.commentController,
            hintFontColor: const Color(0XFF0B0B0B),
            hintFontSize: 15,
            textFontSize: 15,
            bgColor: const Color(0XFFF2F2F2),
            borderRadiusValue: 10,
            borderColor: const Color(0XFFF2F2F2),
            inputFormatters: [
              NoLeadingSpaceFormatter(),
            ],
            prefixIcon: Image.asset('assets/images/search_black.png', color: const Color(0xff0B0B0B), height: 20, width: 20),
            onChanged: (String value) {
              if (value.isEmpty) {
                widget.onClear(); // <--- This is the important part
              }
            },
            suffixIcon:  widget.commentController.text.isNotEmpty?MyInkWell(
              onTap:  widget.onClear,
              child: Image.asset('assets/images/clear.png', color: appBlackColor, height: 20, width: 20),
            )  : null,
          ),
        ),
        const SizedBox(width: 12),
        Image.asset('assets/images/scan.png', height: 24, width: 24),
      ],
    );
  }
}


