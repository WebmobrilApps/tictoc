import 'package:flutter/material.dart';
import 'package:tictoc/screens/inbox/other_profile_menu.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68), // Set the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffF2F2F2),
          elevation: 0.0,
          centerTitle: true,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50.0), // Adjust padding for vertical alignment
            child: Row(
              children: [
                UiHelper.horizontalSpace(width: 6),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Image.asset(
                    "assets/images/back_arrow_black.png",
                    height: 28,
                    width: 28,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 21, // Controls the overall size of the avatar
                        backgroundColor: appBlackColor,// Border color
                        child: CircleAvatar(
                          radius: 20, // Inner circle (image container)
                          backgroundImage: AssetImage('assets/images/inbox2.png'),
                        ),
                      ),
                      //const SizedBox(width: 8),
                      //Image.asset('assets/images/inbox2.png', height: 40, width: 40),
                      const SizedBox(width: 8),
                      Flexible(
                        child: mediumText14(
                          context,
                          "DisaSmith",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          textColor: appBlackColor,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){
                    CustomNavigator.push(context: context, screen: const OtherProfileMenu());
                  },
                  icon: Image.asset(
                    "assets/images/more_horiz.png",
                    height: 30,
                    width: 30,
                  ),
                ),
                UiHelper.horizontalSpace(width: 18),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                UiHelper.verticalSpace(height: 18),
                const CircleAvatar(
                  radius: 39.5, // Controls the overall size of the avatar
                  backgroundColor: appBlackColor,// Border color
                  child: CircleAvatar(
                    radius: 38.5, // Inner circle (image container)
                    backgroundImage: AssetImage('assets/images/inbox2.png'),
                  ),
                ),

             //   Image.asset('assets/images/inbox2.png', height: 80, width: 80),
                UiHelper.verticalSpace(height: 6),
                mediumText14(context, 'DisaSmith'),
                mediumText14(context, '@disasmith356',textColor: const Color(0xff484848)),
                UiHelper.verticalSpace(height: 6),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mediumText14(context, '@420 following',textColor: const Color(0xff484848)),
                    mediumText14(context, '@260 followers',textColor: const Color(0xff484848)),
                  ],
                ),
                UiHelper.verticalSpace(height: 12),
                smallText12(context, getCurrentTime(),textColor: const Color(0xff484848)),

              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left:18,right:18,bottom: 14), // Raise the buttons slightly
        child: customMultipleTextField1(
          height: 50,
          hintText: 'Send a message',
          hintFontWeight: FontWeight.w500,
          controller: commentController,
          inputBgColor:Colors.white,
          hintFontColor: appGreyColor,
          hintFontSize: 16,
          prefixIcon: Image.asset('assets/images/camera_pink.png',height: 40,width: 40,),
          suffixIcons: [
            Image.asset('assets/images/gallery_grey.png', height: 20, width: 20),
            const SizedBox(width: 14),
            Image.asset('assets/images/share_grey.png', height: 22, width: 22),
          ],
        ),
      ),
    );
  }
}

