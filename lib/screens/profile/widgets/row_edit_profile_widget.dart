import 'package:flutter/material.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class RowEditProfileWidget extends StatelessWidget {
  final String title;
  final String desc;
  final Widget? trailingIcon; // Pass the widget directly (e.g., Image.asset)
  final VoidCallback? onTap;

  const RowEditProfileWidget({
    super.key,
    required this.title,
    required this.desc,
    this.trailingIcon, // Optional trailing widget
    this.onTap, // Optional onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () async {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 3,
              child: mediumText14(context, title)),
          const SizedBox(width: 12,),
          Expanded(
            flex: 8,
            child: Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(child: smallText12(context, desc,
                    maxLines: 1,overflow: TextOverflow.ellipsis,
                    textColor: const Color(0xff404040))),
                const SizedBox(width: 12),
                trailingIcon ?? // If no icon is provided, show nothing
                    Image.asset(
                      'assets/images/right_arrow.png', // Default image
                      color: const Color(0xff404040),
                      height: 10,
                      width: 6,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}