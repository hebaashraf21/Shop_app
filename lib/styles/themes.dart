import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/styles/colors.dart';


ThemeData Darktheme= ThemeData(
                   primaryColor: defaultColor,
                   primarySwatch: buildMaterialColor(defaultColor),
                    scaffoldBackgroundColor: HexColor('737CA1'),
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20,
                      titleTextStyle: TextStyle(
                          color: HexColor('1F1B24'),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      elevation: 0,
                      backgroundColor: HexColor('1F1B24'),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('1F1B24'),
                          statusBarBrightness: Brightness.light),
                      iconTheme: IconThemeData(
                        color: Color.fromARGB(255, 178, 160, 196),
                      ),
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        backgroundColor: HexColor('1F1B24'),
                        elevation: 30,
                        unselectedItemColor: Color.fromARGB(255, 168, 170, 195),
                        selectedItemColor: Color.fromARGB(255, 106, 94, 149),
                        type: BottomNavigationBarType.fixed),

                        fontFamily: 'Cairo-Black',
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: HexColor('1F1B24'))));


ThemeData LightTheme= ThemeData(
  primaryColor: defaultColor,
                    primarySwatch: buildMaterialColor(defaultColor),
                    appBarTheme: AppBarTheme(
                      actionsIconTheme: IconThemeData(color: defaultColor),
                      titleSpacing: 20,
                      titleTextStyle: TextStyle(
                          color: Color.fromRGBO(46, 20, 117, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarBrightness: Brightness.light),
                      iconTheme: IconThemeData(
                        color: Color.fromRGBO(46, 20, 117, 1),
                      ),
                    ),
                    fontFamily: 'Cairo-Black',


                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        elevation: 30,
                        unselectedItemColor: Color.fromARGB(255, 108, 108, 108),
                        selectedItemColor: Color.fromRGBO(46, 20, 117, 1),
                        type: BottomNavigationBarType.fixed),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                          
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)));                           