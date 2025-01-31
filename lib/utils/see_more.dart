import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/utils/color.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  const SeeMoreText({super.key, required this.text});

  @override
  State<SeeMoreText> createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String truncatedText = widget.text.length > 150
        ? widget.text.substring(0, 150)
        : widget.text;

    return RichText(
      text: TextSpan(
        text: isExpanded || widget.text.length <= 150
            ? widget.text
            : '$truncatedText...',
        style: GoogleFonts.jost(fontSize:12,color:const Color(0xff404040),fontWeight: FontWeight.w400,),
        children: widget.text.length > 150
            ? [
          TextSpan(
            text: isExpanded ? '   See less' : '   See more',
            style: GoogleFonts.jost(fontSize:14,color:appGreyColor,fontWeight: FontWeight.w400,),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
          ),
        ]
            : [],
      ),
    );
  }
}
