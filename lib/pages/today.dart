library agenda;

import 'package:agenda_lezioni/utils/status.dart';
import 'package:flutter/material.dart';
import '../utils/class/lesson.dart';
import '../utils/class/subject.dart';
import '../utils/class/note.dart';
import '../widget/card.dart';
import '../widget/text.dart';
import '../utils/colors.dart';
import 'setTime/setTime.dart';

class Today extends StatefulWidget {
  @override
  _today createState() => _today();
}

class _today extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 1.5,
              alignment: Alignment.bottomLeft,
              image: AssetImage("assets/images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Header('Lezioni di oggi'),
              SizedBox(
                height: 20,
              ),
              getLessons(),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Header('Note di oggi'),
                    SizedBox(
                      height: 20,
                    ),
                    getNote(),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
            Navigator.of(context).push(SetTimeRoute(() => {setState(() => {})}))
          },
          icon: Icon(Icons.toggle_on),
          label: Text('imposta orario'),
          backgroundColor: accentColor(context),
        ));
  }
}

Column getLessons() {
  List<Widget> lista = List<Widget>();
  List<Lesson> sub = Status.register.getCurrentday();
  DateTime now = new DateTime.now();
  TimeOfDay current = new TimeOfDay(hour: now.hour, minute: now.minute);
  for (int i = 0; i < sub.length; i++) {
    //sub[i] = current lesson
    lista.add(sub[i].inInterval(current)
        ? lessonCardCurrentInRow(sub[i], i + 1)
        : lessonCardInRow(sub[i], i + 1));
  }
  if (sub.length == 0) {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Icon(Icons.emoji_emotions),
              SizedBox(height: 10),
              Center(
                child: Text('Non ci sono lezioni oggi',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "OpenSans")),
              )
            ],
          ),
        ),
      ],
    );
  }
  return Column(children: lista);
}

Column getNote() {
  List<Widget> lista = [];
  List<Note> sub = Status.register.getTodayNote();
  for (int i = 0; i < sub.length; i++) {
    lista.add(noteCardInRow(sub[i]));
  }
  return Column(children: lista);
}
