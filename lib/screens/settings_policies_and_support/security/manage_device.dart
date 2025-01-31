import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_class.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:tictoc/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class ManageDevice extends StatefulWidget {
  const ManageDevice({super.key});

  @override
  State<ManageDevice> createState() => _ManageDeviceState();
}

class _ManageDeviceState extends State<ManageDevice> {
  String deviceName = 'Unknown Device';

  @override
  void initState() {
    super.initState();
    fetchDeviceName();
  }

  Future<void> fetchDeviceName() async {
    String model = await DeviceInfoUtil.getDeviceModel();
    setState(() {
      deviceName = model;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: '',arrowBeforeWidth:14),
      body: Padding(
        padding: const EdgeInsets.only(top:4,left: 16,right: 16),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            largeText16(context, 'Manage devices',fontSize: 20,fontWeight: FontWeight.w500).pOnly(left: 14),
            UiHelper.verticalSpace(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16,right: 16,top: 14,bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffF2F2F2),
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText14(context,'Current device',fontWeight:FontWeight.w500, textColor: const Color(0xff404040)),
                  UiHelper.verticalSpace(height: 14),
                  Row( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/phone.png',height: 25,width: 15,),
                      const SizedBox(width: 14,),
                      Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText14(context, deviceName,fontWeight: FontWeight.w500,
                              textColor: const Color(0xff404040)),
                          mediumText14(context, 'Tictoc app \nGoogle Login \n${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                              textColor: const Color(0xff404040)),
                        ],
                      ),
                    ],
                  ),
                  UiHelper.verticalSpace(height: 6),
                ],
              ),
            ),
            UiHelper.verticalSpace(height: 20),
            Row(
              children: [
                mediumText14(context,'Other Device You’ve Logged In On',fontWeight:FontWeight.w500,
                    textColor: const Color(0xff404040)),
                const SizedBox(width: 10,),
                Image.asset('assets/images/info.png',height: 25,width: 25,),
              ],
            ).pOnly(left: 14),
            UiHelper.verticalSpace(height: 20),
          ],
        ),
      ),
    );
  }
}
