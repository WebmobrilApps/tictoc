import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/screens/profile/logout_delete_bottom.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';
class NotInterested extends StatefulWidget {
  final String tmpToken;
  final int userID;
  const NotInterested({super.key, required this.tmpToken,required this.userID});

  @override
  State<NotInterested> createState() => _NotInterestedState();
}

class _NotInterestedState extends State<NotInterested> {
  List<String> interests = ["Privacy issues","Offensive content",
    "Spending too much time on the app", "Taking a break", "Using other account","Not interested in the content", "Don’t find the content relevant",
    "Don’t feel safe", "Bad recommendations",  "Too many alerts", "Switching platform", "Temporary logout",
    "App is slow",
  ];

  List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevents closing when tapping the Android back button
      },
      child: Scaffold(
        backgroundColor:appBgColor ,
        appBar: const CustomAppBar(title: '',arrowBeforeWidth: 20,),
        body: BlocConsumer<TicTocCubit,TicTocState>(
          listener: (context,state){
            if (state.status == TicTocStatus.userInterestSuccess){
              // UiHelper.toastMessage(state.responseData?.response ?? '');
              PreferenceManager.insertValue(key: TOKEN, value: widget.tmpToken);
              PreferenceManager.insertValue(key: USER_ID, value: widget.userID);
              myUserID = PreferenceManager.getIntegerValue(key: USER_ID) ?? 0;
              CustomNavigator.pushAndRemoveUntil(context: context, screen: const PersistentCustomBottomMenu(initialIndex:0));
            }
            else if(state.status == TicTocStatus.userInterestError){
              print(state.errorData?.message);
              String message = state.errorData?.message ?? state.error ?? "";
              UiHelper.toastMessage(message);
            }
          },
          builder: (context,state){
            return Padding(
              padding: const EdgeInsets.only(left:20,right: 20,bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 //   SizedBox(height: screenHeight*0.1,),
                    largeText16(context, 'Choose your \nReason',fontSize: 36,fontWeight: FontWeight.w800,lineHeight: 1.2),
                    const SizedBox(height: 10),
                    largeText16(context, 'Please select any three point for exiting the app',textColor:const Color(0xff484848),fontWeight: FontWeight.w400,fontSize: 18),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4.0,
                      children: interests.map((interest) {
                        final isSelected = selectedInterests.contains(interest);
                        return ChoiceChip(
                          label: Text(interest,style: GoogleFonts.jost(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w500),),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedInterests.add(interest);
                              } else {
                                selectedInterests.remove(interest);
                              }
                            });
                          },
                          backgroundColor: Colors.white,
                          //  selectedColor: Colors.pink.shade100,
                          selectedColor: Colors.green.shade100,
                          labelPadding:const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.pink : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                            side: BorderSide(color: Colors.grey.shade200), // Light grey border
                          ),
                          elevation: 4, // Subtle shadow
                          shadowColor: Colors.grey.shade200, // Light shadow color
                        );
                      }).toList(),
                    ),
                    SizedBox(height: screenHeight*0.08,),
                    Center(
                      child: pinkButton(
                          width: 285, context: context, labelText:'Continue',
                          isLoading:state.status == TicTocStatus.userInterestLoading,
                          onTap: () async {
                            if(selectedInterests.length<3){
                              UiHelper.toastMessage("Please Select Any Three Reason");
                            }else{
                         //     Navigator.pop(context);
                              isGuest = false;
                              PreferenceManager.clearPreferences();
                            //  BlocProvider.of<TicTocCubit>(context).userInterestCall(interestList,widget.tmpToken);

                               await showModalBottomSheet(
                                isScrollControlled: true,
                                useRootNavigator: true,
                                context: context,
                                builder: (context) => const LogoutDeleteBottom(fromMenu:'logout'),
                              );
                            }
                
                          }
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}