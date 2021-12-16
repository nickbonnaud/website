import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:website/themes/global_colors.dart';

class MainTheme {

  static ThemeData themeData({required BuildContext context}) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Theme.of(context).colorScheme.callToAction
        )
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Theme.of(context).colorScheme.callToActionDisabled;
            }
            return Theme.of(context).colorScheme.callToAction;
          }),
          elevation: MaterialStateProperty.resolveWith<double>((states) => states.contains(MaterialState.pressed) || states.contains(MaterialState.disabled) ? 0 : 2),
        )
      ),

      appBarTheme: AppBarTheme(
        toolbarTextStyle: _getDefaultFont()
      ),
      textTheme: _getTextTheme(context: context),
    );
  }

  static TextTheme _getTextTheme({required BuildContext context}) {
    return GoogleFonts.robotoCondensedTextTheme(Theme.of(context).textTheme);
  }

  static TextStyle _getDefaultFont() {
    return GoogleFonts.robotoCondensed();
  }
}