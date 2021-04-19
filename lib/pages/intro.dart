library agenda;

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widget/text.dart';
import '../widget/buttonStyle.dart';

class IntroRoute extends MaterialPageRoute<void>
{
  IntroRoute() : super(builder: (BuildContext context)
  {
    return Intro();
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
  PageSelectorIntro({Key key}) : super(key: key);

  List<Widget> pages = <Widget>[
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[              
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 128.0,
                    color: Theme.of(context).accentColor,
                  ),
                  child: TabBarView(children: pages),
                ),
              ),
              const TabPageSelector(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Salta'),
                style: elevatedButtonStyle(),
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
    return IntroPage(
      title: 'Benvenuto su \nLess on',
      icon: Icon(Icons.home),
      content: 'La tua giornata, organizzata a portata di telefono',
    );
  }
}

class Page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      title: 'Inserisci tutte le tue materie',
      icon: Icon(Icons.school),
      content: 'Aggiungi materie dalla sezione lezioni',
    );
  }
}

class Page3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      title: 'imposta l\'orario',
      icon: Icon(Icons.toggle_on),
      content: 'Imposta il tuo orario e i tuoi impegni direttamente dalla schermata home',
    );
  }
}

class Page4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      title: 'Aggiungi lezioni',
      icon: Icon(Icons.menu_book),
      content: 'Aggiungi una lezione indicando l’orario di inizio la durata ed il tipo di lezione, l’app ti consiglierà l’orario in automatico',
    );
  }
}

class Page5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      title: 'Aggiungi tutti i tipi di note che vuoi',
      icon: Icon(Icons.event),
      content: 'Aggiungi delle note che ti verranno ridcordate sulla schermata home, divertiti a scoprire tutti i nostri tipi di nota',
    );
  }
}


class IntroPage extends StatelessWidget{

  IntroPage({this.title, this.content, this.icon, this.image})
  {
    assert(title != null, "text can't be null");
    assert(content != null, "content can't be null");
    if(icon != null && image != null)
    {
      throw new Exception("there can bw or an image or an icon");
    }
    else if(icon == null && image != null)
    {
      throw new Exception("there must be or an image or an icon");
    }

    useIcon = false;
    if(icon != null)
    {
      useIcon = true;
    }
    
  }

  bool useIcon;
  Icon icon;
  Widget image;
  String title;
  String content;
  final double space = 20;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(this.title, style: TextStyle(color: PrimaryColor, fontSize: 35, fontFamily: 'comfortaa',), textAlign: TextAlign.center )),
            SizedBox(height: space,),
            Center(child: useIcon ? icon : image),
            SizedBox(height: space,),
            Center(child: GreyText(this.content, textAlign: TextAlign.center, fontSize: 20,)),
          ],
        ),
      ),
    );
  }

}