
import 'package:get/get.dart';
import 'package:sportsslot/presentation/login_screen/binding/login_binding.dart';
import 'package:sportsslot/presentation/login_screen/login_screen.dart';
import 'package:sportsslot/presentation/sign_up_screen/binding/sign_up_binding.dart';
import 'package:sportsslot/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:sportsslot/presentation/splash_screen/binding/splash_binding.dart';
import 'package:sportsslot/presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String splashScreen = '/splash_screen';

  static const String onboardingOneScreen = '/onboarding_one_screen';

  static const String initialRoute = '/initialRoute';

  static const String signUpScreen = '/sign_up_screen';

  static List<GetPage> pages = [
    GetPage(
      transition: Transition.rightToLeft,
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      transition: Transition.rightToLeft,
      name: signUpScreen,
      page: () => SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
/// ----- initialRoute ------------
    GetPage(
      transition: Transition.rightToLeft,
      name: initialRoute,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),

  ];
}
