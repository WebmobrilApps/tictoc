// ignore_for_file: constant_identifier_names


import 'dart:async';

/// URL PATH
//String BASEURL = "http://74.102.68.36:9208";
String BASEURL = "http://52.22.241.165:10055";
String wsContext = "";
String userID = "";
String savedToken = "";
int ipadScreenSize = 600;
double screenHeight = 926.0;
double screenWidth = 428.0;
String? deviceId;
bool isGuest = false;

const TOKEN = 'token';
const EMAIL_ID = 'emailId';
const USER_ID = 'userId';
const PHONE_NO = 'phone_no';
const ISGUEST = 'isGuest';

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



const String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';


const String emailPattern =
    r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';





/// VALIDATION MESSAGE
//const String notConnected = 'You are not connected to internet, Please check your internet connection';
const String notConnected = 'Please Check Your Internet Connection';
const  PLEASE_ENTER_EMAIL_OR_PHONENUMBER = 'Please Enter Email Or Phone Number';
const EMPTY_NAME_VALIDATION = 'Please Enter First Name';
const VALID_NAME_VALIDATION = 'Please Enter Correct Name';
const EMPTY_LASTNAME_VALIDATION = 'Please enter your last name';
const EMPTY_DOB_VALIDATION = "Please enter your DOB";
const EMPTY_AGE_DOB_VALIDATION = "User must be of age 18 years or above";
const VALID_EMAIL_VALIDATION = 'Please enter a valid email address';
const EMPTY_PASSWORD_VALIDATION = 'Please enter a password to continue';
const EMPTY_CONFIRM_PASSWORD_VALIDATION = 'Please Enter Confirm Password';
const EMPTY_OTP_VALIDATION = 'Please enter an OTP';
const EMPTY_EMAIL_VALIDATION = 'Please enter Email ID';
const PASSWORD_LENGTH_VALIDATION =
    'Password should be Between 8-16 characters long.And it should contain Atleast One Number, One Special Character, One Uppercase and One Lowercase.';
const EMPTY_PHONE_NUMBER_VALIDATION = 'Please enter phone number';
const EMPTY_ADDRESS_VALIDATION = 'Please enter your full address';
const EMPTY_DROPDOWN_VALIDATION = 'Please select Content Creator Category';
const EMPTY_SOCIAL_LINK = 'Please enter at least one social media link';
const EMPTY_WEBSITE_URL = "Please enter your website url";
const EMPTY_OLD_PASSWORD_VALIDATION = 'Please enter old/current password';
const EMPTY_NEW_PASSWORD_VALIDATION = 'Please enter new password';
const CONFIRM_PASSWORD_VALIDATION = 'Please enter confirm password';
const PASSWORD_NOTMATCH_VALIDATION =
    "New Password and Confirm Password do not match";
const VALID_PASSWORD_VALIDATION =
    'The password entered does not meet the required criteria. Passwords must be between 8 to 16 characters in length and include at least one uppercase letter, one lowercase letter, one number, and one special character from the following set of characters: !"#\$%&\'()*+,-.:;<=>?@[]^_`{|}~. Please update your password to meet these requirements and try again.';
const MATCHING_PASSWORD_VALIDATION =
// 'The passwords you entered do not match. Please re-enter your password and confirm it to ensure they match';
    'Password And Confirm Password Should Match';
const TNC = 'Please Agree our Terms & Conditions';
const VALID_OTP_CODE_LENGTH_VALIDATION = 'OTP should be of four digits';

