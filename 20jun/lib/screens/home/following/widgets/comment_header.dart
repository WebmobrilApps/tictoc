import 'package:flutter/material.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class CommentHeader extends StatelessWidget {
  final VoidCallback onClose;
  const CommentHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiHelper.verticalSpace(height: 12),
        Center(
          child: Container(
            height: 4, width: 32,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
        UiHelper.verticalSpace(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            largeText16(context, "Comments",fontWeight: FontWeight.w700,fontSize: 18),
            InkWell(
              onTap: onClose,
              child: Padding(
                padding: const EdgeInsets.only(right: 18),
                child: largeText16(context, 'X', fontSize: 20),
              ),
            ),
          ],
        ),
        const Divider(thickness: 0.5, color: Colors.black),
        UiHelper.verticalSpace(height: 6),
      ],
    );
  }
}
