import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/context/app_context.dart';

class Sizer {
  Sizer._();
  static final size = MediaQuery.sizeOf(AppContext.currentContext);


  static double figmaScreenWidth = 392;
  static double figmaScreenHeight = 869;


  // Width Percentage from Figma
  static double wp(double width) {
    return (width / figmaScreenWidth) * size.width;
  }

  // Height Percentage from Figma
  static double hp(double height) {
    return (height / figmaScreenHeight) * size.height;
  }

  static const EdgeInsets defaultPadding = EdgeInsets.symmetric(horizontal: 30);
  static const EdgeInsets smallpadding = EdgeInsets.symmetric(horizontal: 10);
}
