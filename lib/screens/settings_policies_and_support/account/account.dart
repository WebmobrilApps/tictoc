import 'package:flutter/material.dart';
import 'package:tictoc/screens/settings_policies_and_support/account/account_information.dart';
import 'package:tictoc/screens/settings_policies_and_support/account/deactivate_delete_account.dart';
import 'package:tictoc/screens/settings_policies_and_support/account/password.dart';
import 'package:tictoc/screens/settings_policies_and_support/activity_center.dart';
import 'package:tictoc/screens/settings_policies_and_support/live_events.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_navigator.dart';
class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: "Account"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowActivityWidget(labelText: 'Account information',
                onTap: (){CustomNavigator.push(context: context, screen: const AccountInformation());},),
              RowActivityWidget(labelText: 'Password',
                onTap: (){CustomNavigator.push(context: context, screen: const Password());},),
              RowActivityWidget(labelText: 'Deactivate or delete account',
                onTap: (){CustomNavigator.push(context: context, screen: const DeactivateDeleteAccount());},),
            ],
          ),
        ),
      ),
    );
  }
}
