library agenda;

import 'package:flutter/material.dart';

class IntroRoute extends MaterialPageRoute<void>
{
  IntroRoute() : super(builder: (BuildContext context)
  {
    return PageSelectorIntro();
  });
}

class Intro extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageSelectorIntro(),
    );
  }

}

class PageSelectorIntro extends StatelessWidget {
  const PageSelectorIntro({Key key}) : super(key: key);

  static const kIcons = <Icon>[
    Icon(Icons.event),
    Icon(Icons.home),
    Icon(Icons.android),
    Icon(Icons.alarm),
    Icon(Icons.face),
    Icon(Icons.language),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kIcons.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const TabPageSelector(),
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 128.0,
                    color: Theme.of(context).accentColor,
                  ),
                  child: const TabBarView(children: kIcons),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('SKIP'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//5 page as introduction

class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
  }
}