import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/repository/tictoc_repository.dart';
import 'package:tictoc/screens/auth/interest.dart';
//import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tictoc/screens/auth/sign_in.dart';
import 'package:tictoc/screens/banuba_video_editor/audio_browser.dart';
import 'package:tictoc/screens/bottomnavigationbar/bottomnavigation.dart';
import 'package:tictoc/utils/constants.dart';
import 'package:tictoc/utils/network_check/connectivity_listener.dart';
import 'package:tictoc/utils/shared_preference.dart';

import 'firebase_options.dart';

bool loginValue = false;
bool isIOSDevice = true;
String deviceType = "";
String userName = "";

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

  getStoredValue();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
void audioBrowser() => runApp(AudioBrowserWidget());

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
    final repository = TicTocRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TicTocCubit(repository)),
      ],
      child: ScreenUtilInit(
      //  designSize: const Size(360, 690), // normal commonly used
        designSize: const Size(393, 825), // redmi note 9 pro max
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_ , child) {
          return MaterialApp(
            supportedLocales: const [
              Locale('en'),
            ],
            debugShowCheckedModeBanner: false,
            title: 'TicToc',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: loginValue == true
           ? const ConnectivityListener(child: PersistentCustomBottomMenu(initialIndex:0)):
        //   ? PersistentCustomBottomMenu(initialIndex:0):

        const ConnectivityListener(child: SignIn()),
      ),
    );
  }
}


Future<void> getStoredValue() async {
  var token = PreferenceManager.getStringValue(key: TOKEN) ?? '';
  isGuest = PreferenceManager.getBooleanValue(key: ISGUEST) ?? false;
  userID = PreferenceManager.getIntegerValue(key: USER_ID) ?? 0;

  print('isGuest:$isGuest');
  print('userID:$userID');
  print('tokenMain:$token');
  if (token != '') {
    loginValue = true;
  }
  print('loginValue:$loginValue');
}
