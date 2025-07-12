import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class SpacingHelper {
  SpacingHelper._();

  // Height spacing
  static Widget h4() => SizedBox(height: Sizer.hp(4));
  static Widget h8() => SizedBox(height: Sizer.hp(8));
  static Widget h12() => SizedBox(height: Sizer.hp(12));
  static Widget h16() => SizedBox(height: Sizer.hp(16));
  static Widget h20() => SizedBox(height: Sizer.hp(20));
  static Widget h24() => SizedBox(height: Sizer.hp(24));
  static Widget h32() => SizedBox(height: Sizer.hp(32));
  static Widget h40() => SizedBox(height: Sizer.hp(40));
  static Widget h48() => SizedBox(height: Sizer.hp(48));
  static Widget h56() => SizedBox(height: Sizer.hp(56));
  static Widget h64() => SizedBox(height: Sizer.hp(64));

  // Width spacing
  static Widget w4() => SizedBox(width: Sizer.wp(4));
  static Widget w8() => SizedBox(width: Sizer.wp(8));
  static Widget w12() => SizedBox(width: Sizer.wp(12));
  static Widget w16() => SizedBox(width: Sizer.wp(16));
  static Widget w20() => SizedBox(width: Sizer.wp(20));
  static Widget w24() => SizedBox(width: Sizer.wp(24));
  static Widget w32() => SizedBox(width: Sizer.wp(32));
  static Widget w40() => SizedBox(width: Sizer.wp(40));
  static Widget w48() => SizedBox(width: Sizer.wp(48));
  static Widget w56() => SizedBox(width: Sizer.wp(56));
  static Widget w64() => SizedBox(width: Sizer.wp(64));

  // Custom spacing
  static Widget height(double height) => SizedBox(height: Sizer.hp(height));
  static Widget width(double width) => SizedBox(width: Sizer.wp(width));

  // Both height and width
  static Widget box(double width, double height) =>
      SizedBox(width: Sizer.wp(width), height: Sizer.hp(height));
}
