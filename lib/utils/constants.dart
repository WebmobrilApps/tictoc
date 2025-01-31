// ignore_for_file: constant_identifier_names


import 'dart:async';

/// URL PATH
String BASEURL = "http://74.102.68.36:9208";
String wsContext = "";
String userID = "";
String savedToken = "";
int ipadScreenSize = 600;
double screenHeight = 926.0;
double screenWidth = 428.0;

const TOKEN = 'token';
const EMAIL_ID = 'emailId';
const USER_ID = 'userId';

final StreamController<bool> videoPauseStream = StreamController<bool>.broadcast();


class Constants {
  static int cartCount = 0; // Initialize with your default value
  static String currencyCode = '\$'; // Initialize with your default value
  static bool productSelected = false;
  static String mobile_pre_order_id = "";


  static String  hide = "0";
  static String  show = "1";

  static String lineDiscountAmount = "0";
  static String lineCost ="0";
  static String orderEditButton="0";
  static String createItemButton="0";
  static String headerDiscount="0";
  static String createCustomerButton="0";
  static String lineRate="0";
  static String lineInventory="0";
  static String confirmButton="0";
  static String orderDeleteButton= "0";
  static String copyOrder= "0";
  static String savePdf= "0";
  static String sendMail= "0";
}






const String emailPattern =
    r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';




/// VALIDATION MESSAGE
//const String notConnected = 'You are not connected to internet, Please check your internet connection';
const String notConnected = 'Please Check Your Internet Connection';






