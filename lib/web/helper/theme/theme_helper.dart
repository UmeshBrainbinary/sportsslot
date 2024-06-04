import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/core/utils/pref_utils.dart';
import 'package:sportsslot/core/utils/size_utils.dart';
import 'package:sportsslot/theme/custom_text_style.dart';
import 'package:sportsslot/widgets/app_bar/appbar_leading_image.dart';
import 'package:sportsslot/widgets/app_bar/appbar_title.dart';
import 'package:sportsslot/widgets/app_bar/custom_app_bar.dart';
import 'package:sportsslot/widgets/custom_image_view.dart';


/// Helper class for managing themes and colors.
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors(),
    'darkPrimary': PrimaryColors(),
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme,
    'darkPrimary': ColorSchemes.darkPrimaryColorScheme,
  };

  void changeTheme() {
    // _newTheme = _newTheme=="primary"?"darkPrimary":"primary";
    _appTheme = PrefUtils().getThemeData() == "primary" ? "darkPrimary" : "primary";
    PrefUtils().setThemeData(_appTheme);
    Get.forceAppUpdate();
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception("$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.primaryContainer,
      bottomSheetTheme: BottomSheetThemeData(
          surfaceTintColor: PrefUtils().getThemeData() == "primary"
              ? appTheme.whiteA700
              : appTheme.darkgray,
          backgroundColor: PrefUtils().getThemeData() == "primary"
              ? appTheme.whiteA700
              : appTheme.darkgray),
      dialogTheme: DialogTheme(
          surfaceTintColor: PrefUtils().getThemeData() == "primary"
              ? appTheme.whiteA700
              : appTheme.darkgray,
          backgroundColor: PrefUtils().getThemeData() == "primary"
              ? appTheme.whiteA700
              : appTheme.darkgray),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray60001.withOpacity(0.41),
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {

  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(


    bodyLarge: TextStyle(
      color: colorScheme.onErrorContainer,
      fontSize: 16.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: appTheme.gray60001,
      fontSize: 14.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: colorScheme.onErrorContainer,
      fontSize: 12.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: colorScheme.onErrorContainer,
      fontSize: 28.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: colorScheme.onErrorContainer,
      fontSize: 20.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onErrorContainer,
      fontSize: 18.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: appTheme.black900,
      fontSize: 14.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w700,
    ),

  );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFF0E795D),
    primaryContainer: Color(0XFFFFFFFF),
    secondaryContainer: Color(0XFF4E4E4E),

    // Error colors
    onError: Color(0XFF414042),
    onErrorContainer: Color(0XFF030401),

    // On colors(text colors)
    onPrimary: Color(0XFF050505),
    onPrimaryContainer: Color(0XFF263B80),
  );

  static final darkPrimaryColorScheme = ColorScheme.dark(
    // Primary colors
    primary: Color(0XFF0E795D),
    primaryContainer: Color(0XFFFFFFFF),
    secondaryContainer: Color(0XFF4E4E4E),

    // Error colors
    onError: Color(0XFF414042),
    onErrorContainer: Color(0XFF030401),

    // On colors(text colors)
    onPrimary: Color(0XFF050505),
    onPrimaryContainer: Color(0XFF263B80),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Amber
  Color get amber400 => Color(0XFFFFCD19);
  Color get footBollColor => Color(0XFFFFF6E8);
  Color get tenisColor => Color(0XFFE9F6E0);
  Color get basketBollColor => Color(0XFFFAEEE3);
  Color get vollyBollColor => Color(0XFFE7F1FA);
  Color get cricketColor => Color(0XFFFFE8E8);
  Color get kabbadiColor => Color(0XFFF3E1DC);
  Color get bedmintanColor => Color(0XFFE7FAFF);
  Color get golfColor => Color(0XFFE9F2FF);
  Color get archeyColor => Color(0XFFDFDDF5);
  Color get baseballColor => Color(0XFFF8E8E5);
  Color get bithalonColor => Color(0XFFDDEFFE);
  Color get shotingColor => Color(0XFFF9DFDD);
  Color get amber500 => Color(0XFFFFC107);

  // Black
  Color get black900 => PrefUtils().getThemeData() == "primary" ? Color(0XFF000000) : Color(0XFFFFFFFF);


  Color get black40 => Color(0XFF7B7676);
  Color get blackTransperant => Color(0XFF030401);

  // Blue
  Color get blue50 => Color(0XFFE6F1F9);

  Color get blue5001 => Color(0XFFDDEEFD);

  Color get blue5002 => Color(0XFFE8F1FF);
  Color get ratingIconColor => PrefUtils().getThemeData() == "primary" ? Color(0XFFDCDCDC) : black40;
  // BlueGray
  Color get blueGray300 => Color(0XFFA3A3B5);

  Color get blueGray50 => Color(0XFFECF6F4);

  Color get blueGray500 => Color(0XFF668892);

  // Cyan
  Color get cyan300 => Color(0XFF5AC5DF);

  // DeepOrange
  Color get deepOrange300 => Color(0XFFF57E6C);

  Color get deepOrange50 => Color(0XFFF9EDE2);

  Color get deepOrange5001 => Color(0XFFFFE8E8);

  Color get deepOrange5002 => Color(0XFFF3E1DB);

  Color get deepOrange5003 => Color(0XFFF7E8E4);

  Color get deepOrange5004 => Color(0XFFF8DFDC);

  Color get deepOrangeA100 => Color(0XFFDAAA79);

  Color get buttonColor => Color(0XFF0E795D);

  Color get darkInput => Color(0XFF0B0D0C);

  Color get darkgray => Color(0XFF1D201F);

  Color get bgColor => PrefUtils().getThemeData() == "primary"
      ? Color(0XFFFFFFFF)
      : Color(0XFF0B0D0C);

  Color get secondarybgcolor => PrefUtils().getThemeData() == "primary"
      ? Color(0XFFECF6F5)
      : Color(0XFF2F3433);

  // DeepPurple
  Color get deepPurpleA200 => Color(0XFF9747FF);

  // Gray
  Color get gray100 => Color(0XFFF7F7F7);

  Color get textfieldFillColor => PrefUtils().getThemeData() == "primary"
      ? Color(0XFFF8F8F8)
      : Color(0XFF1D201F);

  Color get gray300 => Color(0XFFDBDBDB);

  Color get lightgraynightMode => PrefUtils().getThemeData() == "primary"
      ? Color(0XFFF8F8F8)
      : Color(0XFF2F3433);

  Color get gray30001 => Color(0XFFD6DBF2);

  Color get gray600 => Color(0XFF818181);

  Color get gray60001 => Color(0XFF7B7676);

  Color get gray60028 => Color(0X28787880);

  Color get gray800 => Color(0XFF383E41);

  // Green
  Color get green400 => Color(0XFF65BC6A);

  Color get green50 => Color(0XFFE8F6DF);

  // Indigo
  Color get indigo50 => Color(0XFFDFDCF5);

  // LightBlue
  Color get lightBlue50 => Color(0XFFE6FAFF);

  // LightGreen
  Color get lightGreen400 => Color(0XFF94E061);

  Color get lightGreen500 => Color(0XFF84D052);

  Color get lightGreen800 => Color(0XFF6A823A);

  // Lime
  Color get lime100 => Color(0XFFF8E4C5);

  // Orange
  Color get orange300 => Color(0XFFFEA95C);

  Color get orange30001 => Color(0XFFEFBC4B);

  Color get orange50 => Color(0XFFFFF5E7);

  // Pink
  Color get pink200 => Color(0XFFF48FB1);

  // Red
  Color get red300 => Color(0XFFFB6771);

  Color get red400 => Color(0XFFEA5149);

  Color get red500 => Color(0XFFE64C3C);

  Color get red50001 => Color(0XFFFF3D3D);

  Color get red700 => Color(0XFFCD3232);

  Color get errorColor => Color(0XFFFF3E3E);

  // Teal
  Color get teal50 => Color(0XFFD4E1F4);

  // White
  Color get whiteA700 => Color(0XFFFFFFFE);
  ///---------------------------------------- Web--------------------------------------//////
  //Color get  webBgColor => Color(0xFFECF6F5)
  Color get  webBgColor => Color(0xFFfffbf7);






  Color get  black => Color(0xFF000000);
  Color get  white => Color(0xFFFFFFFF);
  //Color get themeColor =>Color(0xFF0E795D);
  Color get themeColor =>Color(0xFFcf9757);
  Color get lightGrey => Color(0xFF818181);
  Color get Textfill => Color(0xFFF8F8F8);
  Color get lightgrey => Color(0xFF818181);
  Color get Text  =>  Color(0xFF2A323C);
  Color get background  =>  Color(0xFFE0FBF4);
  Color get blueIcon => Color(0xFF5B93FF);
  Color get redIcon => Color(0xFFE71D36);
  Color get dotted => Color(0xFF9A9AA9);
  Color get colorFAFAFA => Color(0xFFFAFAFA);
  Color get color8B8B9A => Color(0xFF8B8B9A);
  Color get colorE6F6F5 => Color(0xFFE6F6F5);
  Color get colorB3B3BF => Color(0xFFB3B3BF);
  Color get colorE6F0FD => Color(0xFFE6F0FD);
  Color get colorCACACA => Color(0xFFCACACA);
  Color get colorA8A8A8 => Color(0xFFA8A8A8);
  Color get colorFF0101 => Color(0xFFFF0101);
  Color get colorFEF3F5 => Color(0xFFFEF3F5);
  Color get color554E56 => Color(0xFF554E56);
  Color get colorF7F9FF => Color(0xFFF7F9FF);
  Color get color1B1B1B => Color(0xFF1B1B1B);
  Color get color151515 => Color(0xFF151515);
  Color get color2D2D2D => Color(0xFF2D2D2D);
  Color get colorA7A7A7 => Color(0xFFA7A7A7);
  Color get colorCECECF => Color(0xFFCECECF);







}
///---------------------------------------- Web--------------------------------------//////



PrimaryColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();

closeApp() {
  Future.delayed(const Duration(milliseconds: 1000), () {
    SystemNavigator.pop();
  });
}

setSafeAreaColor({Color? color}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color ?? appTheme.bgColor,
      systemNavigationBarColor: color ?? appTheme.bgColor,
      statusBarIconBrightness: PrefUtils().getThemeData() == "primary"
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarIconBrightness: PrefUtils().getThemeData() == "primary"
          ? Brightness.dark
          : Brightness.light,
    ),
  );
}

Widget animationfunction(index, child,
    {Duration? listAnimation, Duration? slideduration, Duration? slidedelay}) {
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: listAnimation ?? Duration(milliseconds: 375),
    child: SlideAnimation(
      duration: slideduration ?? Duration(milliseconds: 50),
      delay: slidedelay ?? Duration(milliseconds: 50),
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}

getCustomToast(text) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: appTheme.buttonColor,
    textColor: Colors.white,
    fontSize: 16.fSize,
  );
}

getCommonAppBar(title, {Widget? actionwidget}) {
  return CustomAppBar(
    leadingWidth: 44.h,
    leading: AppbarLeadingImage(
      onTap: () {
        Get.back();
      },
      imagePath: ImageConstant.imgIcDown,
      margin: EdgeInsets.only(left: 20.h, top: 23.v, bottom: 23.v),
    ),
    title: AppbarTitle(text: title, margin: EdgeInsets.only(left: 16.h)),
    actions: [actionwidget ?? SizedBox()],
    styleType: Style.bgFill,
  );
}

getCustomIconButton(icon, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appTheme.textfieldFillColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: CustomImageView(color: appTheme.black900, height: 24.adaptSize, width: 24.adaptSize, imagePath: icon),
      ),
    ),
  );
}

getViewAllRow(title, onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,
          style: theme.textTheme.titleLarge!.copyWith(color: appTheme.black900)),
      GestureDetector(
        onTap: onTap,
        child: Text("lbl_view_all".tr, style: CustomTextStyles.bodyLargeGray60001.copyWith(color: appTheme.gray60001)),
      )
    ],
  );
}
