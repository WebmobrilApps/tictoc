import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ContentPreference extends StatefulWidget {
  const ContentPreference({super.key});

  @override
  State<ContentPreference> createState() => _ContentPreferenceState();
}

class _ContentPreferenceState extends State<ContentPreference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Content preferences'),
      body: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18),
        child: Column(
          children: [
            UiHelper.verticalSpace(height: 12),
            RowContentPrefWidget(
              labelText: 'Filter keywords',
              trailingWidget: Row(
                  children: [
                    largeText16(context, '0',textColor: const Color(0xff86878b)),
                    const SizedBox(width: 6,),
                    Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                  ],),
              onTap: (){},),
            RowContentPrefWidget(
              labelText: 'Restricted Mode',
              trailingWidget: Row(
                children: [
                  largeText16(context, 'Off',textColor: const Color(0xff86878b)),
                  const SizedBox(width: 6,),
                  Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                ],),
              onTap: (){},),
            RowContentPrefWidget(labelText: 'Refresh your for you feed', onTap: (){},),
            RowContentPrefWidget(labelText: 'Muted accounts', onTap: (){},),
          ],
        ),
      ),
    );
  }
}
class RowContentPrefWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback? onTap;
  final bool showDivider;
  final Widget? trailingWidget; // Add this for custom trailing widget



  const RowContentPrefWidget({
    super.key,
    required this.labelText,
    this.onTap,
    this.showDivider = true,
    this.trailingWidget, // Initialize the trailing widget

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8,),
        MyInkWell(
          onTap: () async {
            if (onTap != null) {
              await Future.sync(onTap!);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: mediumText14(context,labelText,fontWeight:FontWeight.w500,
                    maxLines: 1,overflow: TextOverflow.ellipsis,
                    textColor: const Color(0xff404040)).pOnly(left: 14),
              ),
              (trailingWidget ??
                  Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,)
              ).pOnly(right: 10), // Use trailingWidget if provided
            ],
          ),
        ),
        const SizedBox(height: 8,),
        if(showDivider)
          const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}