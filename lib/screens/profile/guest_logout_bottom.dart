import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/sign_up_response.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/custom_navigator.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/shared_preference.dart';
import 'package:tictoc/utils/ui_helper.dart';

class GuestLogoutBottom extends StatefulWidget {
  final String fromMenu;
  final List<int> reasonIds;

  const GuestLogoutBottom({super.key, required this.fromMenu, required this.reasonIds,});

  @override
  State<GuestLogoutBottom> createState() => _GuestLogoutBottomState();
}

class _GuestLogoutBottomState extends State<GuestLogoutBottom> {

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return BlocConsumer<TicTocCubit, TicTocState>(
      listener: (context, state) {
        if (state.status == TicTocStatus.guestLogoutSuccess) {
          isGuest = false;
          PreferenceManager.clearPreferences();
          CustomNavigator.pushAndRemoveUntil(context: context, screen: const SignIn());
        }
        if (state.status == TicTocStatus.guestLogoutError) {
          print(state.errorData?.message);
          String message = state.errorData?.message ?? state.error ?? "";
          UiHelper.toastMessage(message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          reverse: true,
          child: IntrinsicHeight(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: keyboardHeight, // Add padding for the keyboard
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:12,left: 28, right: 28, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UiHelper.verticalSpace(height: 12),
                    largeText16(context, 'Logout',fontWeight: FontWeight.w600,
                        fontSize: 22,
                        textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 18),
                    mediumText14(context, 'Are you sure you want to logout?',
                        textAlign: TextAlign.center,fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
                    UiHelper.verticalSpace(height: 40),
                    mediumText14(context, 'Please enter email for future communication and updates'),
                    UiHelper.verticalSpace(height: 20),
                    customTextField(controller:emailController, hintText: 'Email (Optional)',
                      textInputAction:TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,),
                    UiHelper.verticalSpace(height: 40),
                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallPinkButton(label: 'Yes',fontSize:16,fontWeight: FontWeight.w500,
                          isLoading: state.status == TicTocStatus.guestLogoutLoading,
                          padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                          borderRadius: const BorderRadius.all(Radius.circular(22.5),),
                          onTap: (){

                            //    UiHelper.toastMessage(widget.fromMenu=="fromMenu"?'Logout Successfully':'Account Deleted Successfully');
                            Map<String, dynamic> logoutDetails = {
                              "email": emailController.text.isEmpty?" ":emailController.text,
                              "reason": widget.reasonIds,
                            };
                            print('logoutDetails:$logoutDetails');
                            BlocProvider.of<TicTocCubit>(context).guestLogoutCall(logoutDetails);
                          },
                        ),
                        const SizedBox(width: 60,),
                        SmallPinkButton(label: 'No',fontSize:16,fontWeight: FontWeight.w500,
                          backgroundColor:Colors.white,textColor:buttonColor,
                          border: Border.all(color: buttonColor, width: 1.0),
                          padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                          borderRadius: const BorderRadius.all(Radius.circular(22.5),),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    UiHelper.verticalSpace(height: 18),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}