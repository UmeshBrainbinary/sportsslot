import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsslot/core/service/notification_service.dart';

import 'package:sportsslot/core/utils/initial_bindings.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/routes/app_routes.dart';

import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/login_screen/login_screen.dart';
import 'package:sportsslot/web/Screen/logo_icon/logo_icon_screen.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/service/pref_service.dart';
import 'package:sportsslot/web/utils/pref_keys.dart';


import 'core/utils/logger.dart';
import 'localization/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCDRdW5HiAV8LhwPqnWMZNlwP-qdmM9CFU",
        //authDomain: "ng-booking-application.firebaseapp.com",
        projectId: "sportot-8af62",
        //storageBucket: "ng-booking-application.appspot.com",
        messagingSenderId: "988219226171",
        appId: "1:739072824156:android:e93227264d2e8ddac12799",
        //measurementId: "G-L6363G9BNQ"
      ),
    );
  }else{
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBCAfZFOvkFEkqABD--Ke-xweCClIrhNG0",
          authDomain: "sportot-8af62.firebaseapp.com",
          projectId: "sportot-8af62",
          storageBucket: "sportot-8af62.appspot.com",
          messagingSenderId: "739072824156",
          appId: "1:739072824156:web:b7dcbd7906a55668c12799",
          measurementId: "G-10CT5JQG3X"
      ),
     );
  }



  await NotificationService.init();

  await PrefService.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });


  try {
    await FirebaseMessaging.instance.getToken().then((value) async {
      await PrefService.setValue(PrefKey.fcmToken, value);
      if (kDebugMode) {
        print("FCM Token => ${PrefService.getString(PrefKey.fcmToken)}");
      }
    });
  } catch (e) {
    print(e);
  }


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
  ]).then((value) {

    runApp(MyApp());
  });

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    themeController = Get.put(ThemeController(),permanent: true);
    themeController.isDarkMode.listen((isDarkMode) {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return  (!kIsWeb) ? GetMaterialApp(

      debugShowCheckedModeBanner: false,
      theme: theme,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: 'Sportsslot',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,


    ) : GetMaterialApp(

      debugShowCheckedModeBanner: false,
      // theme: theme,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,

      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: ' Uttarakhand Booking App',
      initialBinding: InitialBindings(),
      // initialRoute: AppRoutes.initialRoute,
      // getPages: AppRoutes.pages,
      home: PrefService.getBool(PrefKeys.isLoggedIn) ?
      // DashboardScreen(child: BookingHistoryScreen(), index: 3)
      DashboardScreen(child: LogoIconScreen(), index: 0)
      // UserDataList(userIds: ["2KMgPmNEcvTGOBN9k6ng","4MdXTGd7nraVTah7r2yX","r5vfQBYhvBj1LnLFk6N5"],)
          : LoginScreen(),
    );
  }
}







