import 'package:flutter/material.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
class ActivityModel extends StatefulWidget {
  const ActivityModel({super.key});

  @override
  State<ActivityModel> createState() => _ActivityModelState();
}

class _ActivityModelState extends State<ActivityModel> {
  int _selectedIndex = 1;  // To keep track of the selected row

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align to the top
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child:   Padding(
              padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap:(){Navigator.pop(context);},
                          child: Image.asset(   "assets/images/back_arrow_black.png", height: 28,width: 28,)),
                      const SizedBox(width: 100,),
                      largeText16(context, 'Activity',fontWeight: FontWeight.w500,fontSize: 20,textColor: const Color(0xff404040)),
                      const SizedBox(width: 10,),
                      Image.asset(   "assets/images/up_arrow.png", height: 25,width: 15,)
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReusableRowWidget(
                    labelText: 'Activity', leadingPath:'assets/images/activity1.png',
                    isSelected: _selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                   ReusableRowWidget(
                    labelText: 'Likes and Favoritest', leadingPath:'assets/images/like_heart.png',
                     isSelected: _selectedIndex == 2,
                     onTap: () {
                       setState(() {
                         _selectedIndex = 2;
                       });
                     },
                   ),
                  ReusableRowWidget(
                    labelText: 'Comments', leadingPath:'assets/images/comments.png',
                    isSelected: _selectedIndex == 3,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                  ),
                  ReusableRowWidget(
                    labelText: 'Add Yours', leadingPath:'assets/images/add_yours.png',
                    isSelected: _selectedIndex == 4,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 4;
                      });
                    },
                  ),
                  ReusableRowWidget(
                    labelText: 'Mentions', leadingPath:'assets/images/mentions.png',
                    isSelected: _selectedIndex == 5,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 5;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class ReusableRowWidget extends StatelessWidget {
  final String leadingPath;
  final String labelText;
  final VoidCallback? onTap;
  final bool isSelected;


  const ReusableRowWidget({
    super.key,
    required this.leadingPath,
    required this.labelText,
    this.onTap,
    this.isSelected = false,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6,),
        MyInkWell(
          onTap: ()async{
            onTap!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(leadingPath,height: 20,width: 20,),
                  const SizedBox(width: 12),
                  mediumText14(context,labelText,fontWeight:FontWeight.w500,
                      textColor: const Color(0xff404040)),
                ],
              ),
              if (isSelected)
                Image.asset(
                  'assets/images/tick_pink.png',
                  height: 20,
                  width: 20,
                ).pOnly(right: 8),
            ],
          ),
        ),
        const SizedBox(height: 6,),
        const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}