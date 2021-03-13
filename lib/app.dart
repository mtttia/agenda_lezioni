library agenda;
import 'package:flutter/material.dart';
import 'home.dart';

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda lezioni',
      home: Home(),
      //theme: //TODO,

    );
  }

}