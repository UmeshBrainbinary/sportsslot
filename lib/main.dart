import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsslot/core/service/notification_service.dart';
import 'package:sportsslot/core/service/pref_service.dart';
import 'package:sportsslot/core/utils/initial_bindings.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/routes/app_routes.dart';

import 'package:sportsslot/theme/theme_helper.dart';


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
    //   options: const FirebaseOptions(
    //       apiKey: "AIzaSyAYXMb3aDY6WE44-Gxpvmr3AF5nDmM1E7M",
    //       authDomain: "ng-booking-application.firebaseapp.com",
    //       projectId: "ng-booking-application",
    //       storageBucket: "ng-booking-application.appspot.com",
    //       messagingSenderId: "988219226171",
    //       appId: "1:988219226171:web:063fd029e9498b8055441e",
    //       measurementId: "G-L6363G9BNQ"
    //     // apiKey: "AIzaSyApIsOz8gGTxjQ3UwskoIWVL21UB69phZQ",
    //     // authDomain: "uttarakhand-booking-app.firebaseapp.com",
    //     // projectId: "uttarakhand-booking-app",
    //     // storageBucket: "uttarakhand-booking-app.appspot.com",
    //     // messagingSenderId: "121756021489",
    //     // appId: "1:121756021489:web:a61a0c215c11e62049af50"
    //   ),
     );
  }



  await NotificationService.init();

  await PrefService.init();




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

class MyApp extends StatelessWidget {
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
      theme: theme,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: 'Sportsslot',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      // home:
      //
      // PrefService.getBool(PrefKeys.isLoggedIn) ?
      // // AddGroundDetailScreen() : LoginScreen(),
      // AddEventDetailScreen()
      // // DashboardScreen(child: LogoIconScreen(), index: 0)
      //     : LoginScreen(),



    );
  }
}