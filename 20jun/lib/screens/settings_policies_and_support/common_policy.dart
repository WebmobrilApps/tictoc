import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
class CommonPolicy extends StatefulWidget {
  final String pageFrom;
  const CommonPolicy({super.key, required this.pageFrom});

  @override
  State<CommonPolicy> createState() => _CommonPolicyState();
}

class _CommonPolicyState extends State<CommonPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const CustomAppBar(title: '',arrowBeforeWidth:10),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22,right: 22),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              largeText16(context, widget.pageFrom,fontSize: 24,
                  fontWeight: FontWeight.w500,textColor: const Color(0xff404040)),
              const SizedBox(height: 16,),
              mediumText14(context, 'Faucibus mollis nunc tellus aliquam volutpat turpis. Praesent aliquam proin risus leo at quam. Eu morbi faucibus sit ridiculus sem. Ac diam mauris sed sed convallis quam aliquam a. Tincidunt penatibus libero gravida adipiscing. Est ultrices dui ornare amet lacus. Ut eget Lorem ipsum dolor sit amet consectetur.mauris commodo congue turpis fermentum odio est porttitor. Dictumst ullamcorper mattis egestas velit id vel. Faucibus enim consequat lectus sagittis mauris quisque nullam. \n\nNulla semper semper proin dolor id. Scelerisque hendrerit tincidunt fringilla sit pharetra fringilla.Praesent aliquam proin risus leo at quam. Eu morbi faucibus sit ridiculus sem. Ac diam mauris sed sed convallis quam aliquam a. Commodo curabitur urna pharetra cursus amet. Sed convallis dictum a nibh eget ultrices penatibus donec sit.\n\nQuis nulla arcu aliquet et vel leo.Praesent aliquam proin risus leo at quam. Eu morbi faucibus sit ridiculus sem. Ac diam mauris sed sed convallis quam aliquam a. Commodo curabitur urna pharetra cursus amet. Sed convallis dictum a nibh eget ultrices penatibus donec sit.')
            ],
          ),
        ),
      ),
    );
  }
}
