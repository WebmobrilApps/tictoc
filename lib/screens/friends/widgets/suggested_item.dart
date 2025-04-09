import 'package:flutter/material.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';

class SuggestedItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback? onTap;

  const SuggestedItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(imagePath, height: 50, width: 50),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(
                          context,
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                        smallText12(
                          context,
                          subtitle,
                          textColor: const Color(0xff484848),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SmallPinkButton(
              width:78,
              label: buttonLabel,
              fontSize: 14,
              onTap: onTap,
            ),
          ],
        ),
        UiHelper.verticalSpace(height: 18),
      ],
    );
  }
}
