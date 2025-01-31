import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/shared_preference.dart';

import 'firebase_options.dart';

bool loginValue = false;
bool isIOSDevice = true;
String deviceType = "";
String userName = "";
String? deviceId;


/*void main() {
  getStoredValue();
  runApp(const MyApp());
}*/

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await PreferenceManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
      systemNavigationBarIconBrightness:Brightness.dark,
    statusBarIconBrightness:Brightness.dark,
  ));
  // await FirebaseApi().initNotifications();
  /*if (Platform.isAndroid) {
    deviceType = 'android';
    await FirebaseMessaging.instance.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
  } else {
    deviceType = 'ios';
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await PushNotificationService().setupInteractedMessage();
  //
  // ///notification permission
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );*/

  getStoredValue();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    print('screenHeight:$screenHeight');
    print('screenWidth:$screenWidth');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
    //  designSize: const Size(360, 690), // normal commonly used
      designSize: const Size(393, 825), // redmi note 9 pro max
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const SignIn(),
    );
  }
  /*Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width;
      print('screenHeight:$screenHeight');
      print('screenWidth:$screenHeight');
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return MaterialApp(
        title: 'TicToc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignIn(),
      );
    });
  }*/
}


Future<void> getStoredValue() async {
  var emailID = PreferenceManager.getStringValue(key: EMAIL_ID) ?? '';
  var userID = PreferenceManager.getStringValue(key: USER_ID) ?? "";

  print('emailIDMain:$emailID');
  if (emailID != '') {
    loginValue = true;
  }
  print('loginValue:$loginValue');
}
