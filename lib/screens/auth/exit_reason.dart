import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/leave_reason_response.dart';
import 'package:tictoc/screens/profile/guest_logout_bottom.dart';
import 'package:tictoc/screens/profile/logout_delete_bottom.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:tictoc/utils/ui_helper.dart';

class ExitReason extends StatefulWidget {
  final String tmpToken;
  final int userID;
  const ExitReason({super.key, required this.tmpToken,required this.userID});

  @override
  State<ExitReason> createState() => _ExitReasonState();
}

class _ExitReasonState extends State<ExitReason> {
  LeaveReasonResponse leaveReasonResponse = LeaveReasonResponse();
/*  List<String> interests = [
    "App is not attractive as like as Chines TikTok",
    "No latest features and advanced",
    "I have too many social media subscriptions",
    "App is consuming too much battery",
    "Don't know whether App is secured or not",
    "App is very slow in terms of browsing the content and moving",
    "One feature to another",
    "App is hanging too much",
    "Content is not attaracrtive in terms of videos and pic are not HD",
    "Content is stale or very old and no longer attractive",
    "Content Category is not in line of not syncing with content avaibile on App",
  ];*/

  List<Data> dynamicReasons = [];
  List<int> selectedReasonIds = [];

 // List<String> selectedReason = [];

  @override
  void initState() {
    _getProfileAPi();
    super.initState();
  }

  Future<void> _getProfileAPi() async {
    await BlocProvider.of<TicTocCubit>(context).leaveReasonCall();
  }

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
            if (state.status == TicTocStatus.leaveReasonSuccess){
              leaveReasonResponse = state.responseData?.response as LeaveReasonResponse;
              dynamicReasons = leaveReasonResponse.data ?? [];

            }
          },
          builder: (context,state){
            if (state.status == TicTocStatus.leaveReasonLoading) {
              return const CustomLoader();
            }
            if (state.status == TicTocStatus.leaveReasonError) {
              return CustomErrorWidget(
                errorMessage: state.errorData?.message ?? state.error,
                statusCode: state.errorData?.code,
                onRetry: refreshPage,
                onRefresh: refreshPage,
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left:20,right: 20,bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //   SizedBox(height: screenHeight*0.1,),
                    largeText16(context, 'Choose your \nExit Reason',fontSize: 34,fontWeight: FontWeight.w800,lineHeight: 1.2),
                    const SizedBox(height: 10),
                    largeText16(context, 'Please select any three point for exiting the app',textColor:const Color(0xff484848),fontWeight: FontWeight.w400,fontSize: 18),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: dynamicReasons.map((item) {
                        final isSelected = selectedReasonIds.contains(item.id);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedReasonIds.remove(item.id);
                              } else {
                                selectedReasonIds.add(item.id!);
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.green.shade100 : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isSelected)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2.0, right: 6),
                                    child: Icon(Icons.check, color: Colors.green, size: 18),
                                  ),
                                Expanded(
                                  child: Text(
                                    item.reason??'',
                                    style: GoogleFonts.jost(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: screenHeight*0.08,),
                    Center(
                      child: pinkButton(
                          width: 285, context: context, labelText:'Continue',
                          isLoading:state.status == TicTocStatus.userInterestLoading,
                          onTap: () async {
                            print('selectedReasonIds:$selectedReasonIds');
                            if(selectedReasonIds.length<3){
                              UiHelper.toastMessage("Please Select Any Three Reason");
                            }else{
                              //     Navigator.pop(context);
                              //   isGuest = false;
                              //  PreferenceManager.clearPreferences();
                              //  BlocProvider.of<TicTocCubit>(context).userInterestCall(interestList,widget.tmpToken);

                              await showModalBottomSheet(
                                isScrollControlled: true,
                                useRootNavigator: true,
                                context: context,
                                builder: (context) => GuestLogoutBottom(fromMenu:'Exit Reason',reasonIds: selectedReasonIds,),
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

  Future<void> refreshPage() async{
    await _getProfileAPi();
  }
}