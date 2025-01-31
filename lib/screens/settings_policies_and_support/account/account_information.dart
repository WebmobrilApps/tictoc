import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/content_preference.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: "Account information"),
      body: Padding(
        padding: const EdgeInsets.only(top:18,left:18,right: 14),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12,right: 12,top: 16,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowContentPrefWidget(
                    labelText: 'Phone number',
                    trailingWidget: Image.asset('assets/images/right_arrow_1.png',height: 20,width: 10,),
                    onTap: (){
                    //  CustomNavigator.push(context: context, screen: const SecurityAlerts());
                      },
                  ),
                  RowContentPrefWidget(
                    labelText: 'Email',
                    trailingWidget: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5, // Provide a bounded width
                      child: Row( mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: mediumText14(
                              context,
                              'thiru@yopmail.com',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textColor: const Color(0xff404040),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            'assets/images/right_arrow_1.png',
                            height: 20,
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                    //  CustomNavigator.push(context: context, screen: const ManageDevice());
                      },
                  ),
                  RowContentPrefWidget(
                    labelText: 'Account region',
                    showDivider: false,
                    trailingWidget: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5, // Provide a bounded width
                      child: Row( mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: mediumText14(
                              context,
                              'United Arab Emirates',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textColor: const Color(0xff404040),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            'assets/images/right_arrow_1.png',
                            height: 20,
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                    //  CustomNavigator.push(context: context, screen: const ManageDevice());
                      },
                  ),
                  const SizedBox(height: 4,),
                  mediumText14(context, 'Your account region is initially set based on the time and place of registration.',
                      textColor: const Color(0xff86878B)).pOnly(left: 14),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
