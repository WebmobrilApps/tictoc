import 'package:flutter/material.dart';
import 'package:tictoc/screens/inbox/chat_screen.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  final List inboxData = [
    {"storyImage":"assets/images/inbox1.png", "name":"Thiru", "followStatus":"Following", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox2.png", "name":"DisaSmith", "followStatus":"Follow Back", "message":"Follows you"},
    {"storyImage":"assets/images/inbox3.png", "name":"Suriya", "followStatus":"Following", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Angel", "followStatus":"Following","message":"Following"},
    {"storyImage":"assets/images/inbox2.png", "name":"Bengamine", "followStatus":"Follow Back", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox3.png", "name":"Tokyo", "followStatus":"Following","message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Thiru", "followStatus":"Follow Back", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox2.png", "name":"DisaSmith", "followStatus":"Follow Back", "message":"Follows you"},
    {"storyImage":"assets/images/inbox3.png", "name":"Suriya", "followStatus":"Follow Back", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox1.png", "name":"Angel", "followStatus":"Following","message":"Following"},
    {"storyImage":"assets/images/inbox2.png", "name":"Bengamine", "followStatus":"Following", "message":"lorem ipsum"},
    {"storyImage":"assets/images/inbox3.png", "name":"Tokyo", "followStatus":"Follow Back","message":"lorem ipsum"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Follower'),
      body: Padding(
        padding: const EdgeInsets.only(top:4,left: 18,right: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12,),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: inboxData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: MyInkWell(
                              onTap:()async{
                                CustomNavigator.push(context: context, screen: const ChatScreen());
                              },
                              child: Row(
                                children: [
                                  Image.asset(inboxData[index]['storyImage'], height: 50, width: 50,),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        mediumText14(context,inboxData[index]['name'],
                                            maxLines: 1,overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500),
                                        smallText12(context, inboxData[index]['message'],  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if( inboxData[index]['followStatus']=="Follow Back")
                            Row(
                              children: [
                                Container(
                                    padding:  const EdgeInsets.only(left:10,right:10,top:4,bottom: 4),
                                    decoration:  BoxDecoration(
                                      color:buttonColor,
                                      borderRadius: BorderRadius.circular(4),),
                                    child: smallText12(context, 'Follow Back',textColor: whiteColor,fontSize:10,fontWeight: FontWeight.w700)),
                                const SizedBox(width: 6,),
                                Image.asset('assets/images/clear.png',height: 18, width: 18,)
                              ],
                            ),
                          if( inboxData[index]['followStatus']=="")
                            Image.asset('assets/images/soundScreen2.png',height: 56, width: 44,),
                          if( inboxData[index]['followStatus']=="Following")
                            Row(
                              children: [
                                Container(
                                    padding:  const EdgeInsets.only(left:12,right:12,top:4,bottom: 4),
                                    decoration:  BoxDecoration(
                                      color:const Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(4),),
                                    child: smallText12(context, 'Following',textColor: const Color(0xff484848),fontSize:10,fontWeight: FontWeight.w700)),
                              ],
                            ),
                        ],
                      ),
                      if(index+1 != inboxData.length)const SizedBox(height: 14,),

                    ],
                  );
                },
              ),
              const SizedBox(height: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
