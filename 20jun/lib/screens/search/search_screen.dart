import 'package:flutter/material.dart';
import 'package:tictoc/screens/auth/forgot_password.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  int selectedMenuIndex = 0;

  bool isSearchKeyEmpty = true;


  @override
  void initState() {
    super.initState();

    // Listen to changes in the searchController
    searchController.addListener(() {
      setState(() {
        isSearchKeyEmpty = searchController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  final List recentVideoData = [
    {"searchKey":"dance"},
    {"searchKey":"funny video"},
    {"searchKey":"comedy"},
    {"searchKey":"travel"},
    {"searchKey":"foodie"},
  ];
  final List videoCatData = [
    {"image":"assets/images/dance.png","categoryName":"Dance"},
    {"image":"assets/images/sunny.png","categoryName":"Sunny day"},
    {"image":"assets/images/funny.png","categoryName":"Funny"},
    {"image":"assets/images/healthy.png","categoryName":"Healthy"},
    {"image":"assets/images/relaxing.png","categoryName":"Relaxing"},
    {"image":"assets/images/travel.png","categoryName":"Travel"},
    {"image":"assets/images/dance.png","categoryName":"Dance"},
    {"image":"assets/images/sunny.png","categoryName":"Sunny day"},
    {"image":"assets/images/funny.png","categoryName":"Funny"},
    {"image":"assets/images/healthy.png","categoryName":"Healthy"},
    {"image":"assets/images/relaxing.png","categoryName":"Relaxing"},
    {"image":"assets/images/travel.png","categoryName":"Travel"},
    {"image":"assets/images/dance.png","categoryName":"Dance"},
    {"image":"assets/images/sunny.png","categoryName":"Sunny day"},
    {"image":"assets/images/funny.png","categoryName":"Funny"},
    {"image":"assets/images/healthy.png","categoryName":"Healthy"},
    {"image":"assets/images/relaxing.png","categoryName":"Relaxing"},
    {"image":"assets/images/travel.png","categoryName":"Travel"},
    {"image":"assets/images/dance.png","categoryName":"Dance"},
    {"image":"assets/images/sunny.png","categoryName":"Sunny day"},
    {"image":"assets/images/funny.png","categoryName":"Funny"},
    {"image":"assets/images/healthy.png","categoryName":"Healthy"},
    {"image":"assets/images/relaxing.png","categoryName":"Relaxing"},
    {"image":"assets/images/travel.png","categoryName":"Travel"},
    {"image":"assets/images/dance.png","categoryName":"Dance"},
    {"image":"assets/images/sunny.png","categoryName":"Sunny day"},
    {"image":"assets/images/funny.png","categoryName":"Funny"},
    {"image":"assets/images/healthy.png","categoryName":"Healthy"},
    {"image":"assets/images/relaxing.png","categoryName":"Relaxing"},
    {"image":"assets/images/travel.png","categoryName":"Travel"},
  ];

  final List menuSearchesData = [
    {"resultMenu":"Top"},
    {"resultMenu":"Users"},
    {"resultMenu":"Videos"},
    {"resultMenu":"Live"},
    {"resultMenu":"Yoga"},
  ];

  final List searchResultData = [
    {"image":"assets/images/soundScreen1.png","name":"Ajay","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen2.png","name":"Priya","likeCount":"102.2K"},
    {"image":"assets/images/soundScreen3.png","name":"Raji","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","name":"Salman","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","name":"Sahil","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen2.png","name":"Jaggy","likeCount":"663.09K"},
    {"image":"assets/images/soundScreen1.png","name":"Sidarth","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen3.png","name":"Mony","likeCount":"328.2K"},
    {"image":"assets/images/soundScreen4.png","name":"Ashu","likeCount":"983.0K"},
    {"image":"assets/images/soundScreen5.png","name":"Arivu","likeCount":"324.11K"},
    {"image":"assets/images/soundScreen1.png","name":"Dinesh","likeCount":"203.2K"},
    {"image":"assets/images/soundScreen2.png","name":"Mohan","likeCount":"102.2K"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(title: 'Search',
          actionWidget:Stack(
        children: [
          MyInkWell(
            onTap: ()async{
              CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:3));
            },

            child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: Image.asset('assets/images/notification_bell.png', width: 22, height: 22)),
          ),
          Positioned(
            top: 0,right: 0,
            child: Container(
              width: 9, height: 9,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: buttonColor
              ),
              child: Center(child: smallText12(context, '2',fontSize: 6,textColor:Colors.white,fontWeight: FontWeight.w500)),
            ),
          )
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFieldWithBorder(
              hintText: 'Search...',
              controller: searchController,
              prefixIcon: Image.asset('assets/images/search_black.png', height: 20, width: 20),
              suffixIcon: Image.asset('assets/images/clear.png', color:appBlackColor,height: 20, width: 20),

            ),
            UiHelper.verticalSpace(height: 10),
            isSearchKeyEmpty?const SizedBox():
            SizedBox(
              height:30,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection : Axis.horizontal,
                itemCount: menuSearchesData.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      MyInkWell(
                        onTap:()async{
                          setState(() {
                            selectedMenuIndex = index;
                            print('selectedMenuIndex:$selectedMenuIndex');
                          });
                        },
                        child: Container(
                          padding:  const EdgeInsets.only(left:18.5,right:18.5,top:5.5,bottom: 5.5),
                          decoration:  BoxDecoration(
                            color:selectedMenuIndex==index?buttonColor:const Color(0xffECECEC),
                            borderRadius: BorderRadius.circular(5),),
                          child: smallText12(context,
                            fontSize: 10, menuSearchesData[index]['resultMenu'],
                            textColor:selectedMenuIndex==index?whiteColor:bgColor, fontWeight:selectedMenuIndex==index? FontWeight.w700:FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14,),
                    ],
                  );
                },
              ),
            ).pOnly(bottom: 10),
         //   UiHelper.verticalSpace(height: 4),
            Expanded(
              child: SingleChildScrollView(
                child:Column(
                  children: [
                    isSearchKeyEmpty
                        ? SingleChildScrollView(
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              smallText12(
                                context,
                                'Recent Videos',
                                textColor: const Color(0xff484848),
                                fontWeight: FontWeight.w500,
                              ),
                              smallText12(
                                context,
                                'Clear All',
                                textColor: const Color(0xff484848),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ).pOnly(left:2,right: 2),
                          UiHelper.verticalSpace(height: 14),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: recentVideoData.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 4,right: 4),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset('assets/images/recent.png', height: 18, width: 18),
                                            UiHelper.horizontalSpace(width: 8),
                                            smallText12(
                                              context,
                                              recentVideoData[index]['searchKey'],
                                              textColor: const Color(0xff9C9C9C),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Image.asset('assets/images/clear.png', height: 18, width: 18),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              );
                            },
                          ),
                          UiHelper.verticalSpace(height: 14),
                          smallText12(
                            context,
                            'Video you might enjoy',
                            textColor: const Color(0xff484848),
                            fontWeight: FontWeight.w500,
                          ).pOnly(left:2),
                          UiHelper.verticalSpace(height: 14),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: videoCatData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                              mainAxisExtent: 165,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(videoCatData[index]['image']),
                                  Positioned(
                                    bottom: 12,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.0),
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.2),
                                          ],
                                        ),
                                      ),
                                      child: smallText12(
                                        context,
                                        videoCatData[index]['categoryName'],
                                        textColor: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ):
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: searchResultData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 4.0,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(searchResultData[index]['image'],height: 210,fit: BoxFit.cover,width:double.infinity,)),
                                  UiHelper.verticalSpace(height: 6),
                                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            UiHelper.horizontalSpace(width: 2),
                                            Image.asset('assets/images/profile6.png',height: 22,width: 22,),
                                            UiHelper.horizontalSpace(width: 8),
                                            Expanded(
                                              child: smallText12(context,searchResultData[index]['name'],
                                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  fontSize: 10,fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset('assets/images/like_notselected.png',height: 15,width: 15,),
                                          UiHelper.horizontalSpace(width: 4),
                                          smallText12(context, searchResultData[index]['likeCount'],textColor:appGreyColor,fontSize: 8,fontWeight: FontWeight.w500),
                                          UiHelper.horizontalSpace(width: 2),
                                        ],
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(height: 6),
                                  smallText12(context,'dancevideo.tictocapp',fontSize: 10,fontWeight: FontWeight.w500),
                                  smallText12(context,'#tictocapp #dancevideo #dance#groupdance #tictocapp #dancevideo #dance#groupdance',
                                      maxLines: 2,overflow: TextOverflow.ellipsis,textColor: appGreyColor,
                                      fontSize: 10,fontWeight: FontWeight.w500),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }
}
