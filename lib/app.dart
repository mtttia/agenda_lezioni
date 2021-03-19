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
      title: 'Agenda lezioni',
      home : Home(),
      theme: _AgendaTheme,

    );
  }

}

final ThemeData _AgendaTheme = _buildAgendaTheme();

ThemeData _buildAgendaTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: AgendaBlue300,
    primaryColor: AgendaBlue900,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: AgendaBlue900,
      colorScheme: base.colorScheme.copyWith(
        secondary: AgendaBlue300,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: AgendaBackgroundWhite,
    cardColor: AgendaBackgroundWhite,
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

TextTheme _agendaTextTheme(TextTheme base) {
  return base.copyWith().apply(
    fontFamily: 'OpenSans',
  );
}

