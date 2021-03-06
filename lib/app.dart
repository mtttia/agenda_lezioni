library agenda;
import 'package:flutter/material.dart';
import 'home.dart';
import 'utils/status.dart';
import 'utils/colors.dart';

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Less on',
      home : Home(),
      theme: _agendaTheme,
      //darkTheme: ThemeData.dark(),
      darkTheme: _agendaThemeDark,
    );
  }

}

final ThemeData _agendaTheme = _buildAgendaTheme();
//final ThemeData _agendaDarkTheme = _buildAgendaDarkTheme();

ThemeData _buildAgendaTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: SecondaryColor,
    primaryColor: PrimaryColor,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: PrimaryColor,
      colorScheme: base.colorScheme.copyWith(
        secondary: SecondaryColor,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: BackgroundColor,
    cardColor: GreyColor,
    textSelectionColor: GreyLightColor,
    errorColor: AgendaErrorRed,
    
    //Add the text themes
    

    textTheme: _agendaTextTheme(base.textTheme),
    primaryTextTheme: _agendaTextTheme(base.primaryTextTheme),
    accentTextTheme: _agendaTextTheme(base.accentTextTheme),


    // decoration input
    /*
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: AgendaBlue900,
        ),
      ),
      border: OutlineInputBorder(),
    ),
*/

  );
}

TextTheme _agendaTextTheme(TextTheme base) {
  return base.copyWith().apply(
    fontFamily: 'OpenSans',
  );
}


final ThemeData _agendaThemeDark = _buildAgendaThemeDark();

ThemeData _buildAgendaThemeDark() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: SecondaryColor,
    primaryColor: PrimaryColor,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: PrimaryColor,
      colorScheme: base.colorScheme.copyWith(
        secondary: SecondaryColor,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: BackgroundDarkColor,
    cardColor: AccentColor,
    textSelectionColor: GreyLightColor,
    errorColor: AgendaErrorRed,

    //Add the text themes


    textTheme: _agendaTextTheme(base.textTheme),
    primaryTextTheme: _agendaTextTheme(base.primaryTextTheme),
    accentTextTheme: _agendaTextTheme(base.accentTextTheme),


    // decoration input
    /*
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: AgendaBlue900,
        ),
      ),
      border: OutlineInputBorder(),
    ),
*/

  );
}

/*
ThemeData _buildAgendaDarkTheme()
{
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: AgendaDark500,
    primaryColor: AgendaDark300,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: AgendaBlue900,
      colorScheme: base.colorScheme.copyWith(
        secondary: AgendaBlue300,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: AgendaDark900,
    cardColor: AgendaDark700,
    textSelectionColor: AgendaBlue100,
    errorColor: AgendaErrorRed,
    
    //Add the text themes
    

    textTheme: _agendaTextTheme(base.textTheme),
    primaryTextTheme: _agendaTextTheme(base.primaryTextTheme),
    accentTextTheme: _agendaTextTheme(base.accentTextTheme),


    // decoration input
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: AgendaBlue900,
        ),
      ),
      border: OutlineInputBorder(),
    ),


  );
}

*/