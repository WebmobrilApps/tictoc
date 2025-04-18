import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';
class Interest extends StatefulWidget {
  final String tmpToken;
  final int userID;
  const Interest({super.key, required this.tmpToken,required this.userID});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  List<String> interests = [
    "Animals", "Comedy", "Travel", "Food", "Sports", "Beauty & style",
    "Art", "Gaming", "Science & education", "Dance", "DIY", "Auto",
    "Music", "Life hacks", "Oddly satisfying", "Outdoors", "Fandom"
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
              padding: const EdgeInsets.only(left:18,right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight*0.1,),
                  largeText16(context, 'Choose your \ninterest',fontSize: 36,fontWeight: FontWeight.w800,lineHeight: 1.2),
                  const SizedBox(height: 10),
                  largeText16(context, 'Get better video recommendations',textColor:const Color(0xff484848),fontWeight: FontWeight.w400,fontSize: 18),
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
                  SizedBox(height: screenHeight*0.1,),
                  Center(
                    child: pinkButton(
                        width: 285, context: context, labelText:'Continue',
                       isLoading:state.status == TicTocStatus.userInterestLoading,
                        onTap: (){
                          if(selectedInterests.length<3){
                            UiHelper.toastMessage("Please Select Any Three Interest");
                          }else{
                          print('selectedInterests:$selectedInterests');
                          Map<String,dynamic> interestList = {
                            "interest": selectedInterests,
                          };
                          print('interestList:$interestList');
                          BlocProvider.of<TicTocCubit>(context).userInterestCall(interestList,widget.tmpToken);

                          }

                        }
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
