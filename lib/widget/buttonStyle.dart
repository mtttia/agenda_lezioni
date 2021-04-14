library agenda;
import 'package:flutter/material.dart';
import '../utils/colors.dart';


ButtonStyle outlineElevatedButtonStyle()
{
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => BackgroundColor),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => PrimaryColor),   
    shadowColor: MaterialStateProperty.resolveWith<Color>((states) => PrimaryColor),   
    overlayColor: MaterialStateProperty.resolveWith<Color>((states) => GreyLightColor),
  );
}

ButtonStyle elevatedButtonStyle()
{
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => PrimaryColor),
    //foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => PrimaryColor),   
  );
}

ButtonStyle textButtonStyle(){
  return ButtonStyle(
    //backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => PrimaryColor),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => PrimaryColor),
    overlayColor: MaterialStateProperty.resolveWith<Color>((states) => GreyLightColor),
  );  
}
