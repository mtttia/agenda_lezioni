import 'package:flutter/material.dart';

/*
const AgendaBlue50 = Color(0xFFE6FAFE);
const AgendaBlue100 = Color(0xFFD0F9FE);
const AgendaBlue300 = Color(0xFFACF8FB);
const AgendaBlue400 = Color(0xFFA4CEEA);
const AgendaBlue900 = Color(0xFF002C49);
*/

const AgendaBlue50 = Color.fromRGBO(241, 246, 249, 1);
const AgendaBlue100 = Color.fromRGBO(185, 212, 223, 1);
const AgendaBlue300 = Color.fromRGBO(101, 161, 184, 1);
const AgendaBlue400 = Color.fromRGBO(64, 118, 140, 1);
const AgendaBlue900 = Color.fromRGBO(38, 70, 83, 1);

const AgendaCeleste = Color.fromRGBO(62, 204, 187, 1);

const AgendaGreen = Color.fromRGBO(42, 157, 143, 1);

const AgendaOrange400 = Color(0xFFFFA726);

const AgendaBaije = Color.fromRGBO(233, 169, 106, 1);

const AgendaGreen900 = Color(0xFF2B4443);

const AgendaErrorRed = Color.fromRGBO(231, 111, 81, 1);

const AgendaSurfaceWhite = Color(0xFFFAFEFF);
const AgendaBackgroundWhite = Colors.white;

const AgendaYellow = Color.fromRGBO(233, 196, 106, 1);

const AgendaCardLite = Color.fromRGBO(241, 246, 249, 0.5);

//NEW PALETTE
const PrimaryColor = Color(0xFF677250);
const SecondaryColor = Color(0xFF9EA482);
const GreyColor = Color(0xFFCDC5B2);
const GreyLightColor = Color(0xFFEDE6DE);
const BackgroundColor = Color(0xFFF2F2F2);
const BackgroundDarkColor = Color(0xff2b2b2b);
const AccentColor = PrimaryColor;


//FOR DARKMODE

Color accentColor(BuildContext context){
  //return Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : AccentColor;
  return AccentColor;
}

Color backColor(BuildContext context){
  return Theme.of(context).brightness == Brightness.dark ? BackgroundDarkColor : BackgroundColor;
}