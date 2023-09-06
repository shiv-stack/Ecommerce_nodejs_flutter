import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppColors{
  static Color accent = const Color(0xff1ab7c3);
  static Color text = const Color(0xff212121);
   static Color textLight = const Color(0xFF8A8A8A);
   static Color white = const Color(0xffffffff);

}
class Themes{
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.text),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: AppColors.text,
      )

    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.accent,
      secondary: AppColors.accent,

    )
  );
}

class TextStyles{
   static TextStyle h1=  TextStyle(
    fontSize: 48,
    fontWeight:FontWeight.bold ,
    color:AppColors.text,
   );//heading 1
    static TextStyle h2=  TextStyle(
    fontSize: 32,
    fontWeight:FontWeight.bold ,
    color:AppColors.text,
   );
    static TextStyle h3=  TextStyle(
    fontSize: 24,
    fontWeight:FontWeight.bold ,
    color:AppColors.text,
   );
   //heading 2
    static TextStyle b1=  TextStyle(
    fontSize: 18,
    fontWeight:FontWeight.normal ,
    color:AppColors.text,
   );
    static TextStyle b2=  TextStyle(
    fontSize: 16,
    fontWeight:FontWeight.normal ,
    color:AppColors.text,
   );
   

}