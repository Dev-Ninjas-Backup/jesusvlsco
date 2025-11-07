// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF4E53B1);
  static const Color secondary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF5B5B5B);
  static const Color background = Color(0xFFF9F9F9);

  static const Color text = Color(0xFF484848);
  static const Color quill = Color(0xFFEDEEF7);
  static const Color textfield = Color(0xFF949494);

  //progress bar colors
  static const Color progress1 = Color(0xFF06843F);
  static const Color progress2 = Color(0xFFDC1E28);
  static const Color progresstext = Color(0xFF1EBD66);
  static const Color viewcolor = Color(0xFFD9F0E4);
  static const Color circle = Color(0xFFFF9200);

  // static const Color textSecondary = Color(0xFF5B5B5B);
  // static const Color background = Color(0xFFEDEEF7);
  // static const Color border = Color(0xFFC8CAE7);
  // static const Color text = Color(0xFF484848);
  // static const Color quill = Color(0xFFEDEEF7);
  static const Color recognitionColor = Color(0xFFBF8C45);
  static const Color taskCard = Color(0xFFFFE7DA);

  // static const Color textSecondary = Color(0xFF5B5B5B);
  // static const Color background = Color(0xFFEDEEF7);
  // static const Color border = Color(0xFFC8CAE7);
  // static const Color text = Color(0xFF484848);

  //button colors
  static const Color color1 = Color(0xFF4E53B1); // Dark blue color
  static const Color color2 = Color(0xFF767BD5); // Light purple color
  static const Color color4 = Color(0xFFC8CAE7); // Light purple color
  static const Color color3 = Color(0xFF2C2D32); // Dark grey color
  static const Color button1 = Color(0xFFFFE6E7); // Dark grey color
  static const Color button2 = Color(0xFFDDD9FF); // Dark grey color

  //border colors
  static const Color border = Color(0xFFC8CAE7);
  static const Color border1 = Color(0xFFF5F5F5);
  static const Color border2 = Color(0xFFC5C5C5);
  static const Color border3 = Color(0xFFEDEEF7); // Dark grey color


  //list colors

  static const Color list = Color(0xFFD9F0E4);
  static const Color gridcard = Color(0xFFE8E6FF);


   // Bright yellow for highlights and accents

  // Bright yellow for highlights and accents

  // static const Color progress1 = Color(0xFF06843F);
  // static const Color progress2 = Color(0xFFDC1E28);
  // static const Color progresstext = Color(0xFF1EBD66);
  // static const Color viewcolor = Color(0xFFD9F0E4);

  // static const Color textSecondary = Color(0xFF5B5B5B);
  static const Color textSecondaryGrey = Color(0xFF949494);
  static const Color progressIndicatorColor = Color(0xFF41BD5D);
  static const Color requestListItemColor = Color(0xFFC8CAE7);
  static const Color shiftCardColor = Color(0xFFEDEEF7);



  // Bright yellow for highlights and accents
  static const Color accent = Color(
    0xFF89A7FF,
  ); // Softer blue for a modern touch

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xfffff9a9e), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );

  // Gradient Colors
  static const Gradient loginGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight, // Horizontal right shift
    colors: [Color(0xFF4E53B1), Color(0xFF767BD5), Color(0xFF2C2D32)],
  );

  // // Brand Colors
  // static const Color primary = Color(
  //   0xFF4E53B1,
  // ); // Darker primary for a more professional look
  // static const Color secondary = Color(
  //   0xFFFEC601,
  // ); // Bright yellow for highlights and accents
  // static const Color accent = Color(
  //   0xFF89A7FF,
  // ); // Softer blue for a modern touch

  // // Gradient Colors
  // static const Gradient linearGradient = LinearGradient(
  //   begin: Alignment(0.0, 0.0),
  //   end: Alignment(0.707, -0.707),
  //   colors: [Color(0xFFF9A9E9), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  // );
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textBlackShade = Color(0xFF484848);
  // Darker shade for better readability
  // static const Color textSecondary = Color(
  //   0xFF757575,
  // ); // Neutral grey for secondary text
  static const Color textWhite = Colors.white;

  // Background Colors
  static const Color backgroundLight = Color(
    0xFFF9FAFB,
  ); // Light neutral for clean look
  static const Color backgroundDark = Color(
    0xFF121212,
  ); // Dark background for contrast in dark mode
  static const Color primaryBackground = Color(
    0xFFFFFFFF,
  ); // Pure white for primary content areas

  static const Color secondaryBackground = Color(
    0xFFF9F9F9,
  ); // Light grey for secondary content areas

  // Surface Colors
  static const Color surfaceLight = Color(
    0xFFE0E0E0,
  ); // Light grey for elevated surfaces
  static const Color surfaceDark = Color(
    0xFF2C2C2C,
  ); // Dark grey for elevated surfaces in dark mode

  static const Color dividerColor = Color(0xFFE4E5F3);
  // Container Colors
  static const Color lightContainer = Color(
    0xFFF1F8E9,
  ); // Soft green for a subtle highlight

  // Utility Colors
  static const Color success = Color(0xFF4CAF50); // Green for success messages
  static const Color warning = Color(0xFFFFA726); // Orange for warnings
  static const Color error = Color(0xFFF44336); // Red for error messages
  static const Color info = Color(
    0xFF29B6F6,
  ); // Blue for informational messages
}
