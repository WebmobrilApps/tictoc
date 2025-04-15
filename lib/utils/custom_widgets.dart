import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/ui_helper.dart';
Widget customImageAsset({
  required String imagePath,
  double height = 50,
  double width = 50,
  BoxFit fit = BoxFit.scaleDown,
}) {
  return Image.asset(
    imagePath,
    height: height,
    width: width,
    fit: fit,
  );
}



void snackBarMessage(BuildContext context, String msg, {TextAlign textAlign = TextAlign.left}) {
  // Remove any currently displayed SnackBar to prevent stacking
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      textAlign: textAlign,
    ),
  ));
}


// Common Button
Widget blueButton({
  required BuildContext context,
  required String labelText,
  VoidCallback? onTap,
  double height = 35.0,
  double? width = double.infinity,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w600, //FontWeight.w400
  Color buttonColor = AppColors.greenButtonColor,
  Color textColor = const Color(0xffFFFFFF),
  bool isLoading = false,
  double borderRadiusValue = 5.0,
  Widget? imageWidget,
}) {
  return MyInkWell(
    onTap: () async {
      if (onTap != null) onTap();
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xff4579BD),
        border: Border.all(
            color: Colors.grey.withOpacity(0.3), width: 0.1,
            style: BorderStyle.solid), //Border.all
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
        boxShadow: [
          BoxShadow(
            color:  AppColors.blackColor.withOpacity(0.15), // Specify color and opacity
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 2.5), // Offset for bottom shadow
          ),
          BoxShadow(
            color:  AppColors.blackColor.withOpacity(0.15), // Specify color and opacity
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(1, 2.5), // Offset for bottom shadow
          ),
        ],
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(width: 24, height: 24,
          child: CircularProgressIndicator(color: CupertinoColors.white,strokeWidth:2.5),)
            : Row(  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageWidget != null) ...[
                  imageWidget,
                  const SizedBox(width: 8),
                ],
                smallText12(context, labelText,
                fontSize: fontSize,
                fontWeight: fontWeight,
                maxLines: 1,
                textColor: textColor),
              ],
            ),
      ),
    ),
  );
}


// Common Button
Widget commonButton({
  required BuildContext context,
  required String labelText,
  VoidCallback? onTap,
 // double height = 50.0,
  double? height,
  double? width = double.infinity,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w700, //FontWeight.w400
  Color buttonColor = AppColors.greenButtonColor,
  Color textColor = const Color(0xffFFFFFF),
  bool isLoading = false,
  double borderRadiusValue = 25,
}) {
  // Define screen width and ipad screen size for condition
  double screenWidth = MediaQuery.of(context).size.width;

  // Set the default height based on screen width
  height ??= screenWidth > ipadScreenSize ? 58 : 50;

  return MyInkWell(
    onTap: () async {
      if (onTap != null) onTap();
    },
    child: Container(
      height: height,
      width: width,
     /* decoration: BoxDecoration(
       color: buttonColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),*/
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(
            color: Colors.grey.withOpacity(0.3), width: 0.1,
            style: BorderStyle.solid), //Border.all
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
        boxShadow: [
          BoxShadow(
            color:  AppColors.blackColor.withOpacity(0.15), // Specify color and opacity
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 1.5), // Offset for bottom shadow
          ),
          BoxShadow(
            color:  AppColors.blackColor.withOpacity(0.15), // Specify color and opacity
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 1.5), // Offset for bottom shadow
          ),
        ],
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(width: 24, height: 24,
          child: CircularProgressIndicator(color: CupertinoColors.white,strokeWidth:2.5),)
            : largeText16(context, labelText,
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            maxLines: 1,
            textColor: textColor),
      ),
    ),
  );
}

Widget customTextField({
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false, // Add this parameter
  TextCapitalization textCapitalization = TextCapitalization.none,
  Widget? prefixIcon,
  Widget? suffixIcon,
  double? height,
  TextInputType? keyboardType,
  bool readOnly = false,
  double hintFontSize = 12,
  FontWeight hintFontWeight = FontWeight.w400,//FontWeight.normal
  Color hintFontColor = const Color(0xff9D9D9D),
  Color boxShadowColor = const Color(0xFF000000),
  double textFontSize = 12,
  FontWeight textFontWeight = FontWeight.w400,//FontWeight.normal
  Color textFontColor = const Color(0xff000000),
  Color bgColor =  Colors.white,
  EdgeInsets? contentPadding = const EdgeInsets.only(left: 20,right: 20,),
  TextAlign textAlign = TextAlign.start, // Add this parameter
  TextInputAction? textInputAction,
  VoidCallback? onTap,
  double borderRadiusValue = 30.0,
  bool particularSideRadius = false,
  void Function(String)? onChanged,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
  bool isEnabled = true,
  VoidCallback? onEditingComplete, // Add this parameter
  FocusNode? focusNode, // Add this parameter
}) => Container(
//  height: height ?? 50,
  height: height ?? 50,
  decoration: BoxDecoration(
    color: bgColor,
    border: Border.all(
        color: Colors.grey.withOpacity(0.3), width: 0.1,
        style: BorderStyle.solid), //Border.all
    borderRadius: particularSideRadius? BorderRadius.only(
      topLeft: Radius.circular(borderRadiusValue),
      bottomLeft: Radius.circular(borderRadiusValue),
    ):
    BorderRadius.all(Radius.circular(borderRadiusValue)),
    boxShadow: [
      BoxShadow(
        // color: const Color(0xFFFF0235).withOpacity(0.25), // Specify color and opacity
        color:  boxShadowColor.withOpacity(0.25), // Specify color and opacity
        spreadRadius: 0,
        blurRadius: 4,
        offset: const Offset(0, 2.5), // Offset for bottom shadow
      ),
    ],
  ),
  child: TextFormField(
    controller: controller,
    obscureText:obscureText,
    readOnly: readOnly,
    maxLength: maxLength,
    inputFormatters: inputFormatters, // Pass inputFormatters here
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    cursorColor: Colors.blue,
    style: GoogleFonts.inter(
      fontWeight: textFontWeight, fontSize: textFontSize,
      color: textFontColor,),
    onTap: onTap,
    onChanged:onChanged,
    enabled: isEnabled,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        fontWeight: hintFontWeight, fontSize: hintFontSize,
        color: hintFontColor,),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      counterText: ""
    ),
    textAlign: textAlign, // Set the text alignment
    textInputAction: textInputAction,
    onEditingComplete: onEditingComplete, // Set the onEditingComplete callback
    focusNode: focusNode, // Set the focusNode
  ),
);

Widget customTextFieldWithBorder({
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false, // Add this parameter
  TextCapitalization textCapitalization = TextCapitalization.none,
  Widget? prefixIcon,
  Widget? suffixIcon,
  double? height,
  TextInputType? keyboardType,
  bool readOnly = false,
  double hintFontSize = 12,
  FontWeight hintFontWeight = FontWeight.w400,//FontWeight.normal
  Color hintFontColor = const Color(0xff9D9D9D),
  Color boxShadowColor = const Color(0xFF000000),
  Color borderColor = const Color(0xff484848),
  double textFontSize = 12,
  FontWeight textFontWeight = FontWeight.w400,//FontWeight.normal
  Color textFontColor = const Color(0xff000000),
  Color bgColor =  Colors.white,
  EdgeInsets? contentPadding = const EdgeInsets.only(left: 20,right: 20,),
  TextAlign textAlign = TextAlign.start, // Add this parameter
  TextInputAction? textInputAction,
  VoidCallback? onTap,
  double borderRadiusValue = 160.0,
  bool particularSideRadius = false,
  void Function(String)? onChanged,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
  bool isEnabled = true,
  VoidCallback? onEditingComplete, // Add this parameter
  FocusNode? focusNode, // Add this parameter
}) => Container(
//  height: height ?? 50,
  height: height ?? 50,
  decoration: BoxDecoration(
    color: bgColor,
    border: Border.all(
        color: borderColor, width: 1.0,
        style: BorderStyle.solid), //Border.all
    borderRadius: particularSideRadius? BorderRadius.only(
      topLeft: Radius.circular(borderRadiusValue),
      bottomLeft: Radius.circular(borderRadiusValue),
    ):
    BorderRadius.all(Radius.circular(borderRadiusValue)),
  ),
  child: TextFormField(
    controller: controller,
    obscureText:obscureText,
    readOnly: readOnly,
    maxLength: maxLength,
    inputFormatters: inputFormatters, // Pass inputFormatters here
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    cursorColor: Colors.blue,
    style: GoogleFonts.inter(
      fontWeight: textFontWeight, fontSize: textFontSize,
      color: textFontColor,),
    onTap: onTap,
    onChanged:onChanged,
    enabled: isEnabled,
    decoration: InputDecoration(
        prefixIcon: prefixIcon != null ?
        SizedBox(
          height: 24,width: 24,
          child: Center(child: prefixIcon),): null,
        suffixIcon: suffixIcon != null ?
        SizedBox(
          height: 24,width: 24,
          child: Center(child: suffixIcon),): null,
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontWeight: hintFontWeight, fontSize: hintFontSize,
          color: hintFontColor,),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        counterText: ""
    ),
    textAlign: textAlign, // Set the text alignment
    textInputAction: textInputAction,
    onEditingComplete: onEditingComplete, // Set the onEditingComplete callback
    focusNode: focusNode, // Set the focusNode
  ),
);

Widget customTextField2({
  required String label,
  required TextEditingController controller,
  required TextInputType keyboardType,
  double? height,
  bool obscureText = false, // Add this parameter
  List<TextInputFormatter>? inputFormatters,
  TextCapitalization textCapitalization = TextCapitalization.none,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool? isEnabled = true,
  TextInputAction? textInputAction,
  void Function()? onTap,
  String hintText = "",
  FocusNode? focusNode,
  bool isObscure = false,
  bool readOnly = false,
}) {
  return SizedBox(
    height: height ?? 50,
    child: TextFormField(
      enabled: isEnabled,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      onTap: onTap,
      readOnly: readOnly,
      style: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color:  Colors.white,),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLines: 1,
      cursorColor: Colors.white,
      focusNode: focusNode,
      textInputAction: textInputAction,
      decoration: InputDecoration(
      /*  prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: prefixIcon,
        ),*/
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: suffixIcon,
        ),
       /* prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),*/
      //  filled: true,
        fillColor: Colors.red,
       // floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        hintText: hintText,
        labelStyle: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white,),
        hintStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: const Color(0xffc4c4c4),),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
     //   contentPadding: const EdgeInsets.only(left: 2, right: 10,),
        contentPadding: const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 3),

      ),
      inputFormatters: inputFormatters, // Pass inputFormatters here
    ),
  );
}


Widget customMultipleTextField({
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false, // Add this parameter
  TextCapitalization textCapitalization = TextCapitalization.none,
  Widget? prefixIcon,
  Widget? suffixIcon,
  double? height,
  TextInputType? keyboardType,
  bool readOnly = false,
  double hintFontSize = 16,
  FontWeight hintFontWeight = FontWeight.w400,//FontWeight.normal
  Color hintFontColor = const Color(0xffA4A4A4),
  Color boxShadowColor = const Color(0xFF000000),
  Color inputBgColor = Colors.white,
  double textFontSize = 16,
  FontWeight textFontWeight = FontWeight.w400,//FontWeight.normal
  Color textFontColor = const Color(0xff000000),
  EdgeInsets? contentPadding = const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
  TextAlign textAlign = TextAlign.start, // Add this parameter
  TextInputAction? textInputAction,
  VoidCallback? onTap,
  double borderRadiusValue = 30.0,
  bool particularSideRadius = false,
  void Function(String)? onChanged,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,

  bool isEnabled = true,
  VoidCallback? onEditingComplete, // Add this parameter
  FocusNode? focusNode, // Add this parameter
}) => Container(
//  height: height,
  decoration: BoxDecoration(
    color: inputBgColor,
    border: Border.all(
        color: Colors.grey.withOpacity(0.3), width: 0.1,
        style: BorderStyle.solid), //Border.all
    borderRadius: particularSideRadius? BorderRadius.only(
      topLeft: Radius.circular(borderRadiusValue),
      bottomLeft: Radius.circular(borderRadiusValue),
    ):
    BorderRadius.all(Radius.circular(borderRadiusValue)),
    boxShadow: [
      BoxShadow(
        color:  const Color(0xff555E68).withOpacity(0.15), // Specify color and opacity
        spreadRadius: 0,
        blurRadius: 1,
        offset: const Offset(0, 0.0), // Offset for bottom shadow
      ),
    ],
  ),
  child:TextFormField(
    controller: controller,
    keyboardType: TextInputType.multiline,
    maxLines: null, // Set to null to allow unlimited lines
    style: GoogleFonts.jost(
      fontWeight: textFontWeight, fontSize: textFontSize,
      color: textFontColor,),
    cursorColor: Colors.black,
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: GoogleFonts.jost(
          fontWeight: hintFontWeight, fontSize: hintFontSize,
          color: hintFontColor,),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        counterText: ""
    ),
    textAlign: textAlign,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
  ),
);

Widget customMultipleTextField1({
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false,
  TextCapitalization textCapitalization = TextCapitalization.none,
  Widget? prefixIcon,
  List<Widget>? suffixIcons, // Replace with a list of widgets
  double? height,
  TextInputType? keyboardType,
  bool readOnly = false,
  double hintFontSize = 16,
  FontWeight hintFontWeight = FontWeight.w400,
  Color hintFontColor = const Color(0xffA4A4A4),
  Color boxShadowColor = const Color(0xFF000000),
  Color inputBgColor = Colors.white,
  double textFontSize = 16,
  FontWeight textFontWeight = FontWeight.w400,
  Color textFontColor = const Color(0xff000000),
  EdgeInsets? contentPadding = const EdgeInsets.only(left: 6, right: 20, top: 20, bottom: 12),
  TextAlign textAlign = TextAlign.start,
  TextInputAction? textInputAction,
  VoidCallback? onTap,
  double borderRadiusValue = 30.0,
  bool particularSideRadius = false,
  void Function(String)? onChanged,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
  bool isEnabled = true,
  VoidCallback? onEditingComplete,
  FocusNode? focusNode,
}) =>
    Container(
      decoration: BoxDecoration(
        color: inputBgColor,
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 0.6,
        ),
        borderRadius: particularSideRadius
            ? BorderRadius.only(
          topLeft: Radius.circular(borderRadiusValue),
          bottomLeft: Radius.circular(borderRadiusValue),
        )
            : BorderRadius.all(Radius.circular(borderRadiusValue)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff555E68).withOpacity(0.15), // 15% opacity
            spreadRadius: 0, // Spread value
            blurRadius: 10, // Blur value from Figma
            offset: const Offset(0, 0), // No offset
          ),
        ],
      ),
      child: Row( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (prefixIcon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
              child: prefixIcon,
            ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.multiline,
            //  maxLines: null,
              maxLines: 4,
              minLines: 1,
              style: GoogleFonts.inter(
                fontWeight: textFontWeight,
                fontSize: textFontSize,
                color: textFontColor,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                hintText: hintText,
                hintStyle: GoogleFonts.inter(
                  fontWeight: hintFontWeight,
                  fontSize: hintFontSize,
                  color: hintFontColor,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                counterText: "",
              ),
              textAlign: textAlign,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          if (suffixIcons != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: suffixIcons,
              ),
            ),
        ],
      ),
    );

Widget smallText12(BuildContext context, String msg, {
  double fontSize = 12,
  Color textColor = appBlackColor,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  int? maxLines,
  double? lineHeight,
  TextOverflow? overflow,
  bool isUnderlined = false,
}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.jost(fontWeight: fontWeight, fontSize: fontSize, color: textColor,),
    /*  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontFamily: "Inter",
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        height: lineHeight,
        decoration:isUnderlined ? TextDecoration.underline : TextDecoration.none,
      ),*/
    );



Widget mediumText14(BuildContext context, String msg, {
  double fontSize = 14,
  //Color textColor = const Color(0xff000000),
  Color textColor = appBlackColor,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration? decoration, // Add this parameter
  Color? decorationColor = whiteColor, // Add decoration color
  int? maxLines,
  TextOverflow? overflow,}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
       style:GoogleFonts.jost(fontWeight: fontWeight, fontSize: fontSize, color: textColor, decoration: decoration,decorationColor:decorationColor),
    /*  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: AppConstants.fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: localIsDarkMode?const Color(0xffFFFFFF):textColor),*/
    );

Widget largeText16(BuildContext context, String msg, {
  double fontSize = 16,
 // Color textColor = blackColor,
  Color textColor = appBlackColor,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  int? maxLines,
  double? lineHeight,
  TextOverflow? overflow,}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style:GoogleFonts.jost(fontWeight: fontWeight, fontSize: fontSize, color: textColor,height: lineHeight),
    );




Widget poppinsSmall12(BuildContext context, String msg, {
  double fontSize = 12,
  Color textColor = appBlackColor,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  int? maxLines,
  double? lineHeight,
  TextOverflow? overflow,
  bool isUnderlined = false,
}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.poppins(fontWeight: fontWeight, fontSize: fontSize, color: textColor,),
      /*  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontFamily: "Inter",
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        height: lineHeight,
        decoration:isUnderlined ? TextDecoration.underline : TextDecoration.none,
      ),*/
    );

Future<bool> isConnected() async {

  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  print('connectivityResult:${connectivityResult}');
 // if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
 /* if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)
      || connectivityResult.contains(ConnectivityResult.ethernet) || connectivityResult.contains(ConnectivityResult.bluetooth)
      || connectivityResult.contains(ConnectivityResult.vpn)) {*/
  if (connectivityResult.contains(ConnectivityResult.none)) {
   return false;
  } else {
    return true;
  }
  /*if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true; // Internet connection is available
  } else {
    return false; // No internet connection
  }*/
}

class MyInkWell extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onTap;
  final String notConnectedMessage;

  const MyInkWell({
    Key? key,
    required this.child,
    required this.onTap,
    this.notConnectedMessage = notConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
     //   FocusScope.of(context).requestFocus(FocusNode());
        FocusScope.of(context).unfocus();
        if (await isConnected()) {
          onTap();
        } else {
          UiHelper.toastMessage(notConnectedMessage);
        }
      },
      child: child,
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Only allow one decimal point
    if (newValue.text.contains('.') &&
        newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
      return oldValue;
    }
    return newValue;
  }
}
class RangeTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}

Widget cachedImageWidget({
  required String image,
  double height = 65.0,
  double? width = 65.0,
  double borderRadiusValue = 10.0, // Default value for borderRadius
  BoxFit fit = BoxFit.cover, // Default value for fit
  bool? hasProfileImg = false,
}) {
  return CachedNetworkImage(
    imageUrl: image.isNotEmpty ? image : "",
    imageBuilder: (context, imageProvider) => Container(
      height: height,width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        image: DecorationImage(image: imageProvider, fit: fit),
      ),
    ),
    placeholder: (context, url) => SizedBox(
      height: height,width: width,
      child: const Center(
        child: CupertinoActivityIndicator(
          color: Color(0xffFF0134),),
      ),
    ),
    errorWidget: (context, url, error) =>  ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusValue),
      child: Image.asset(hasProfileImg==true?'assets/images/no_profile.png':'assets/images/no_image.jpeg',
        height: height,width: width,
      ),
    ),
  );
}

Widget cachedImageFullHeight({
  required String image,
  double borderRadiusValue = 20.0, // Default value for borderRadius
  BoxFit fit = BoxFit.cover, // Default value for fit
  double? width = double.infinity,
  double? height,                  // Optional height

}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadiusValue),
    child: CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => const SizedBox(
        child: Center(
          child: CupertinoActivityIndicator(
            color: Color(0xffFF0134),),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpeg',),
    ),
  );
}
Future<String> getDeviceType() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    if (iosInfo.model.toLowerCase().contains('ipad')) {
      return 'iPad';
    } else {
      return 'iPhone';
    }
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    double screenSize = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.shortestSide;
    if (screenSize > 600) { // Common threshold for tablets
      return 'iPad';
    } else {
      return 'Android';
    }
  } else {
    return 'Unknown';
  }
}

loader(BuildContext context) {
  Loader.show(context,
      isSafeAreaOverlay: false,
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: const CircularProgressIndicator(color: Color(0xff4579BD),),
      themeData: Theme.of(context).copyWith(
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
      overlayColor: Colors.black38);
}
String capsFirstChar(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " " && cap == true) {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
      cap = false;
    }
  }
  return result;
}
String parseAndFormat(TextEditingController controller) {
  if (controller.text.isEmpty) {
    return '0.00';
  }
  try {
    return double.parse(controller.text).toStringAsFixed(2);
  } catch (e) {
    // Handle the error if the text is not a valid double
    return '0.00';
  }
}

String convertDateFormat(String originalDate) {
  // Parse the original date string to a DateTime object
  DateTime parsedDate = DateTime.parse(originalDate);

  // Format the DateTime object to the desired format
  String formattedDate = DateFormat('MM-dd-yyyy').format(parsedDate);

  return formattedDate;
}
Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // Unique ID on Android
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor; // Unique ID on iOS
  } else {
    return null;
  }
}




class TextFormFieldWithLabel extends StatelessWidget {
  final String? label; // Made label nullable
  final TextEditingController controller;
  final String hintText;
  final EdgeInsets? contentPadding;
  final TextInputType keyboardType;
  final bool obscureText;
  final double height;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isEnabled;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool readOnly;
  final Color? bottomBorderColor;
  final Color? textFontColor;
  final Color? cursorColor;
  final int? maxLength;

   const TextFormFieldWithLabel({
    super.key,
    this.label, // Now nullable
    required this.controller,
    this.hintText = "",
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.height = 50,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.textInputAction,
    this.onTap,
    this.focusNode,
    this.readOnly = false,
    this.bottomBorderColor,
    this.textFontColor,
    this.cursorColor,
    this.maxLength
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        obscuringCharacter: '*',
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        enabled: isEnabled,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: readOnly,
        cursorColor: cursorColor??Colors.white,
        style: GoogleFonts.jost(fontWeight: FontWeight.w500,
          fontSize: 16, color: textFontColor ?? Colors.white,),
        decoration: InputDecoration(
          labelText: label?.isNotEmpty == true ? label : null,
          hintText: hintText,
          labelStyle: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white,),
          hintStyle: GoogleFonts.jost(fontWeight: FontWeight.w400, fontSize: 16, color: const Color(0xffc4c4c4),),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: suffixIcon,
          ),
        //  contentPadding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 3,),
          contentPadding:contentPadding,
          focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: bottomBorderColor?? Colors.white, width: 2),
          ),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: bottomBorderColor ?? Colors.white, width: 2),
          ),
          border:  UnderlineInputBorder(
            borderSide: BorderSide(color:bottomBorderColor ?? Colors.white, width: 2),
          ),
          counterText: ""
        ),
      ),
    );
  }
}

Widget pinkButton({
  required BuildContext context,
  required String labelText,
  VoidCallback? onTap,
  double height = 50.4,
  double? width = double.infinity,
  double? labelImageGap = 8,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.w600, //FontWeight.w400
  Color buttonColor = buttonColor,
  Color textColor = AppColors.whiteColor,
  bool isLoading = false,
  double borderRadiusValue = 25.2,
  String fontFamily = "Poppins",
  Widget? imageWidget,
}) {
  return MyInkWell(
    onTap: () async {
      if (onTap != null) onTap();
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(color: buttonColor, width: 0.1, style: BorderStyle.solid), //Border.all
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row horizontally
          children: [
            if (imageWidget != null) ...[
              imageWidget,
              SizedBox(width: labelImageGap), // Add spacing between image and text
            ],
            isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: CupertinoColors.white,
                strokeWidth: 2.5,
              ),
            )
                : Text(
              labelText,
              style: fontFamily==fontFamily?GoogleFonts.jost(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ):GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    ),
  );
}

/*Widget pinkButton({
  required BuildContext context,
  required String labelText,
  VoidCallback? onTap,
  double height = 50.04,
  double? width = double.infinity,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.w600, //FontWeight.w400
  Color buttonColor = buttonColor,
  Color textColor = AppColors.whiteColor,
  bool isLoading = false,
  double borderRadiusValue = 25.2,
  Widget? imageWidget,
}) {
  return MyInkWell(
    onTap: () async {
      if (onTap != null) onTap();
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(color: buttonColor, width: 0.1, style: BorderStyle.solid), //Border.all
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(width: 24, height: 24,
          child: CircularProgressIndicator(color: CupertinoColors.white,strokeWidth:2.5),)
            :Text(labelText,style: GoogleFonts.poppins( fontSize: fontSize,
            fontWeight: fontWeight, color: textColor), maxLines: 1,),
          *//*  : largeText16(context, labelText,
            fontSize: fontSize,
            fontWeight: fontWeight,
            maxLines: 1,
            textColor: textColor),*//*
      ),
    ),
  );
}*/

String formatTime(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final secondsPart = (seconds % 60).toString().padLeft(2, '0');
  return '$minutes:$secondsPart';
}

class GreenCircle extends StatelessWidget {
  final double size; // Size of the circle
  final Color color; // Color of the circle
  const GreenCircle({super.key,
    this.size = 9.0, // Default size
    this.color = Colors.green, // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}



class SmallPinkButton extends StatelessWidget {
  final VoidCallback? onTap; // Make onTap nullable
  final String? label;
  final Widget? icon;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding; // Padding for the button
  final BorderRadiusGeometry borderRadius; // Border radius
  final Border? border; // Optional border property
  final bool isLoading;
  final double? width;

  const SmallPinkButton({
    super.key,
    this.onTap, // onTap is now optional
    this.label,
    this.icon,
    this.backgroundColor = buttonColor,
    this.textColor = Colors.white,
    this.fontSize = 11.0,
    this.fontWeight = FontWeight.w700,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.border, // Default is no border
    this.isLoading = false,
    this.width,

  });

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () async {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          border: border, // Use the optional border
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: CupertinoColors.white,strokeWidth:2.5),):
            label != null?Center(child: smallText12(context, label!,textColor: textColor,fontSize:fontSize,fontWeight: fontWeight)): icon!,
      ),
    );
  }
}

String getCurrentTime() {
  final now = DateTime.now();
  return DateFormat('h:mm a').format(now); // Formats time like "2:17 PM"
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If the new text starts with a space, keep the old value
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}

/*class EmptyListFound extends StatelessWidget {
  final double topPadding;
  final String message;
  final double fontSize;
  final Color textColor;

  const EmptyListFound({
    super.key,
    this.topPadding = 150,
    this.message = 'There is no suggestion list',
    this.fontSize = 18,
    this.textColor = appBlackColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Center(
          child: mediumText14(context, message, fontSize: fontSize,textColor: textColor,textAlign: TextAlign.center),
        ),
      ),
    );
  }
}*/



