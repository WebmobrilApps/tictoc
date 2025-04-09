import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/profile/following_list.dart';
import 'package:tictoc/screens/settings_policies_and_support/content_preference.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/manage_app_permissions.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/manage_device.dart';
import 'package:tictoc/screens/settings_policies_and_support/security/security_alerts.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/toggle_switch.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool isPrivateAccount = false;
  bool isActivityStatus = false;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Privacy',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:12,left: 18,right: 18,bottom: 18),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffF2F2F2),
                ),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mediumText14(context,'Discoverability',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 6,right: 6),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: mediumText14(context,"Private account",fontWeight:FontWeight.w500,
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    textColor: const Color(0xff484848)),
                              ),
                              ToggleSwitch(
                                isActive: isPrivateAccount,
                                onTap: () {
                                  setState(() {
                                    isPrivateAccount = !isPrivateAccount;
                                  });
                                },
                              ).pOnly(right: 10), // Use trailingWidget if provided
                            ],
                          ),
                          UiHelper.verticalSpace(height: 4),
                          smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Eu turpis molestie lacus enim nulla enim amet habitant suscipit. Sagittis sed facilisi eu interdum tempus facilisi duis in.',
                          textColor: const Color(0xff86878B)),
                          UiHelper.verticalSpace(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: mediumText14(context,"Activity status",fontWeight:FontWeight.w500,
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    textColor: const Color(0xff484848)),
                              ),
                              ToggleSwitch(
                                isActive: isActivityStatus,
                                onTap: () {
                                  setState(() {
                                    isActivityStatus = !isActivityStatus;
                                  });
                                },
                              ).pOnly(right: 10), // Use trailingWidget if provided
                            ],
                          ),
                          UiHelper.verticalSpace(height: 4),
                          smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Eu turpis molestie lacus enim nulla enim amet habitant suscipit. Sagittis sed facilisi eu interdum tempus facilisi duis in.',
                              textColor: const Color(0xff86878B)),
                          UiHelper.verticalSpace(height: 14),
                          RowContentPrefWidget(
                            labelText: 'Suggest your account to others',
                            trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                            onTap: (){
                              //CustomNavigator.push(context: context, screen: const SecurityAlerts());
                              },
                          ),
                          RowContentPrefWidget(
                            labelText: 'Sync contacts and Facebook friends',
                            trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                            onTap: (){
                            //  CustomNavigator.push(context: context, screen: const ManageDevice());
                              },
                          ),
                          RowContentPrefWidget(
                              labelText: 'Location Services',
                              showDivider: false,
                              trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,)
                          ),
                          smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Eu turpis molestie lacus enim nulla enim amet habitant suscipit. Sagittis sed facilisi eu interdum tempus facilisi duis in.Euturpis molestie lacus enim nulla enim amet habitant suscipit. Sagittis sed facilisi eu interdum tempus .',
                              textColor: const Color(0xff86878B)).pOnly(left: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              UiHelper.verticalSpace(height: 20),
              mediumText14(context, 'Interactions',
                  fontSize: 14,
                  textColor: const Color(0xff404040),fontWeight: FontWeight.w500),
              UiHelper.verticalSpace(height: 12),
              RowPrivacyWidget(
                  labelText: 'Comments',
                  leadingPath: 'assets/images/comments_black.png',
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Mentions',
                  leadingPath: 'assets/images/mentions_black.png',
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Direct Messages',
                  leadingPath: 'assets/images/direct_messages.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'Friends',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Reuse of content',
                  leadingPath: 'assets/images/reuse_of_content.png',
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Display profile when sharing links',
                  leadingPath: 'assets/images/sharing_link.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'On',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Downloads',
                  leadingPath: 'assets/images/downloads.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'On',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Following List',
                  leadingPath: 'assets/images/following_list.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'EveryOne',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){
                    CustomNavigator.push(context: context, screen: const FollowingList());
                  }),
              RowPrivacyWidget(
                  labelText: 'Liked videos',
                  leadingPath: 'assets/images/liked_videos.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'Only you',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Favorite sounds',
                  leadingPath: 'assets/images/favourite_sounds.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'Off',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Post views',
                  leadingPath: 'assets/images/post_views.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'Off',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Profile views',
                  leadingPath: 'assets/images/profile_views.png',
                  trailingWidget: Row(
                    children: [
                      mediumText14(context, 'On',textColor: const Color(0xff9c9c9c),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                    ],
                  ),
                  onTap:(){}),
              RowPrivacyWidget(
                  labelText: 'Blocked accounts',
                  leadingPath: 'assets/images/blocked_accounts.png',
                  onTap:(){}),
            ],
          ),
        ),
      ),
    );
  }
}

class RowPrivacyWidget extends StatelessWidget {
  final String leadingPath;
  final String labelText;
  final VoidCallback? onTap;
  final bool showDivider;
  final Widget? trailingWidget; // Add this for custom trailing widget


  const RowPrivacyWidget({
    super.key,
    required this.leadingPath,
    required this.labelText,
    this.onTap,
    this.showDivider = true,
    this.trailingWidget, // Initialize the trailing widget
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6,),
        MyInkWell(
          /*    onTap: ()async{
            onTap!();
          },*/
          onTap: () async {
            if (onTap != null) {
              await Future.sync(onTap!);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(leadingPath,height: 18,width: 18,),
                  const SizedBox(width: 8),
                  mediumText14(context,labelText,fontWeight:FontWeight.w500,
                      textColor: const Color(0xff404040)),
                ],
              ),
              (trailingWidget ??
                  Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,)
              ).pOnly(right: 10),
            /*  Image.asset(
                'assets/images/right_arrow_1.png',
                height: 20,
                width: 20,
              ).pOnly(right: 8),*/
            ],
          ),
        ),
        const SizedBox(height: 6,),
        if(showDivider)
          const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}