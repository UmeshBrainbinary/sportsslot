import 'package:flutter/material.dart';
import 'package:sportsslot/core/utils/size_utils.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeGray600 => theme.textTheme.bodyLarge!.manrope.copyWith(
        color: appTheme.gray600,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyLargeGray60001 => theme.textTheme.bodyLarge!.manrope.copyWith(
        color: appTheme.gray60001,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.manrope.copyWith(
        color: theme.colorScheme.onPrimary,
    fontFamily: 'Montserrat-Medium',

      );
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.manrope.copyWith(
        color: theme.colorScheme.primary,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyLargeSecondaryContainer => theme.textTheme.bodyLarge!.manrope.copyWith(
        color: theme.colorScheme.secondaryContainer,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyMediumLightgreen800 => theme.textTheme.bodyMedium!.manrope.copyWith(
        color: appTheme.lightGreen800,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyMediumOnErrorContainer => theme.textTheme.bodyMedium!.manrope.copyWith(
        color: theme.colorScheme.onErrorContainer,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.manrope.copyWith(
        color: theme.colorScheme.primary,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyMediumPrimaryContainer => theme.textTheme.bodyMedium!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer,
    fontFamily: 'Montserrat-Medium',
      );
  static get bodyMediumRed50001 => theme.textTheme.bodyMedium!.manrope.copyWith(
        color: appTheme.red50001,
    fontFamily: 'Montserrat-Medium',
      );
  // Title text style
  static get titleLarge22 => theme.textTheme.titleLarge!.manrope.copyWith(
        color: appTheme.black900,
        fontSize: 22.fSize,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.manrope.copyWith(
        color: theme.colorScheme.onPrimary,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleLargePrimary => theme.textTheme.titleLarge!.manrope.copyWith(
        color: theme.colorScheme.primary,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMedium16 => theme.textTheme.titleMedium!.manrope.copyWith(
        fontSize: 16.fSize,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.manrope.copyWith(
        color: appTheme.black900,
        fontSize: 16.fSize,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumBold => theme.textTheme.titleMedium!.manrope.copyWith(
        fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumBold16 => theme.textTheme.titleMedium!.manrope.copyWith(
    color: appTheme.black900,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumGray60001 => theme.textTheme.titleMedium!.manrope.copyWith(
        color: appTheme.gray60001,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumManropeGray60001 =>
      theme.textTheme.titleMedium!.manrope.copyWith(
        color: appTheme.gray60001,
        fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.onPrimary,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumPrimary700 => theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
        fontSize: 16.fSize,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumPrimary16 => theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumPrimaryBold => theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat-Medium',
      );
  static get titleMediumPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontFamily: 'Montserrat-Medium',
      );
  static get webtittle =>
      theme.textTheme.displayLarge!.manrope.copyWith(
        fontFamily: 'Montserrat-Medium',
      );


}

extension on TextStyle {
  TextStyle get manrope {
    return copyWith(
      fontFamily: 'Montserrat-Medium',
    );

  }
}

