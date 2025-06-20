import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/screens/notification/system_notification_setting.dart';
import 'package:tictoc/screens/settings_policies_and_support/activity_center.dart';
import 'package:tictoc/screens/settings_policies_and_support/settingsAndPrivacy.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/see_more.dart';
import 'package:tictoc/utils/toggle_switch.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isLikes = false;
  bool isComments = false;
  bool isNewFollowers = false;
  bool isMentions = false;
  bool isReposts = false;
  bool isActivityStatus = false;
  bool isDirectMessagesPreview = false;
  bool isPostFromPeopleYouMayKnow = false;
  bool isPostsYouMightLike = false;
  bool isVideosFromAccountsYouFollow = false;
  bool isVideosFromPeopleYouMayKnow = false;
  bool isVideosYouMightLike = false;
  bool isLIVENotificationSettings = false;
  bool isWeeklyScreenTimeUpdates = false;
  bool isPeopleYouMayKnow = false;
  bool otherIsWeeklyScreenTimeUpdates = false;
  final animationDuration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: 'Notifications',arrowBeforeWidth:10),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22,right: 22),
              child: Column(
                children: [
                  RowActivityWidget(labelText: 'In-app notifications',
                    onTap: (){// CustomNavigator.push(context: context, screen: const LiveEvents());
                      },),
                  RowActivityWidget(labelText: 'Push notification schedule',
                    onTap: (){// CustomNavigator.push(context: context, screen: const LiveEvents());
                    },),
                ],
              ),
            ),
            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 17,right: 17),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Interactions',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Likes',
                          trailingWidget: ToggleSwitch(
                            isActive: isLikes,
                            onTap: () {
                              setState(() {
                                isLikes = !isLikes;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Comments',
                          trailingWidget: ToggleSwitch(
                            isActive: isComments,
                            onTap: () {
                              setState(() {
                                isComments = !isComments;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'New followers',
                          trailingWidget: ToggleSwitch(
                            isActive: isNewFollowers,
                            onTap: () {
                              setState(() {
                                isNewFollowers = !isNewFollowers;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Mentions',
                          trailingWidget: ToggleSwitch(
                            isActive: isMentions,
                            onTap: () {
                              setState(() {
                                isMentions = !isMentions;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Reposts',
                          trailingWidget: ToggleSwitch(
                            isActive: isReposts,
                            onTap: () {
                              setState(() {
                                isReposts = !isReposts;
                              });
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Messages',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Activity status',
                          trailingWidget: ToggleSwitch(
                            isActive: isActivityStatus,
                            onTap: () {
                              setState(() {
                                isActivityStatus = !isActivityStatus;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Direct messages',
                          trailingWidget: Row(
                            children: [
                              mediumText14(context, 'Everyone',textColor: const Color(0xffADADAD)),
                              const SizedBox(width: 6,),
                              Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                            ],),
                          onTap: (){},),
                        RowNotificationWidget(
                          labelText: 'Direct messages preview',
                          trailingWidget: ToggleSwitch(
                            isActive: isDirectMessagesPreview,
                            onTap: () {
                              setState(() {
                                isDirectMessagesPreview = !isDirectMessagesPreview;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Post Suggestions',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Posts from accounts you follow',
                          trailingWidget: Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Personalized Post Suggestions',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Post from people you may know',
                          trailingWidget: ToggleSwitch(
                            isActive: isPostFromPeopleYouMayKnow,
                            onTap: () {
                              setState(() {
                                isPostFromPeopleYouMayKnow = !isPostFromPeopleYouMayKnow;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Posts you might like',
                          trailingWidget: ToggleSwitch(
                            isActive: isPostsYouMightLike,
                            onTap: () {
                              setState(() {
                                isPostsYouMightLike = !isPostsYouMightLike;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Video Suggestions',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Videos from accounts you follow',
                          trailingWidget: ToggleSwitch(
                            isActive: isVideosFromAccountsYouFollow,
                            onTap: () {
                              setState(() {
                                isVideosFromAccountsYouFollow = !isVideosFromAccountsYouFollow;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Videos from people you may know',
                          trailingWidget: ToggleSwitch(
                            isActive: isVideosFromPeopleYouMayKnow,
                            onTap: () {
                              setState(() {
                                isVideosFromPeopleYouMayKnow = !isVideosFromPeopleYouMayKnow;
                              });
                            },
                          ),
                        ),
                        RowNotificationWidget(
                          labelText: 'Videos you might like',
                          trailingWidget: ToggleSwitch(
                            isActive: isVideosYouMightLike,
                            onTap: () {
                              setState(() {
                                isVideosYouMightLike = !isVideosYouMightLike;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'LIVE',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'LIVE notification settings',
                          trailingWidget: ToggleSwitch(
                            isActive: isLIVENotificationSettings,
                            onTap: () {
                              setState(() {
                                isLIVENotificationSettings = !isLIVENotificationSettings;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Screen Time',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Weekly screen time updates',
                          trailingWidget: ToggleSwitch(
                            isActive: isWeeklyScreenTimeUpdates,
                            onTap: () {
                              setState(() {
                                isWeeklyScreenTimeUpdates = !isWeeklyScreenTimeUpdates;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 12,bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText14(context,'Other',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'People you may know',
                          trailingWidget: ToggleSwitch(
                            isActive: isPeopleYouMayKnow,
                            onTap: () {
                              setState(() {
                                isPeopleYouMayKnow = !isPeopleYouMayKnow;
                              });
                            },
                          ),
                        ),
                        smallText12(context, 'Allow Tictoc to send you notifications about pepole you may know from your contacts, Facebook friends, and more.',).pOnly(left: 10),
                        UiHelper.verticalSpace(height: 10),
                        RowNotificationWidget(
                          labelText: 'Weekly screen time updates',
                          trailingWidget: ToggleSwitch(
                            isActive: otherIsWeeklyScreenTimeUpdates,
                            onTap: () {
                              setState(() {
                                otherIsWeeklyScreenTimeUpdates = !otherIsWeeklyScreenTimeUpdates;
                              });
                            },
                          ),
                        ),
                        UiHelper.verticalSpace(height: 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
class RowNotificationWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback? onTap;
  final Widget? trailingWidget; // Add this for custom trailing widget



  const RowNotificationWidget({
    super.key,
    required this.labelText,
    this.onTap,
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
              mediumText14(context,labelText,fontWeight:FontWeight.w500,
                  textColor: const Color(0xff404040)).pOnly(left: 10),
              (trailingWidget ??
                  Image.asset('assets/images/right_arrow_1.png', height: 20, width: 20,)
              ).pOnly(right: 10), // Use trailingWidget if provided
            ],
          ),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }
}