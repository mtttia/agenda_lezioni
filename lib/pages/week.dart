library agenda;

import 'package:agenda_lezioni/utils/status.dart';
import 'package:flutter/material.dart';
import '../utils/class/lesson.dart';
import '../utils/class/subject.dart';
import '../utils/class/note.dart';
import '../utils/class/weekDay.dart';
import '../widget/card.dart';
import '../widget/text.dart';
import '../utils/colors.dart';

class Week extends StatelessWidget {
  Week({Key key}) : super(key: key);

  static const kIcons = <Icon>[
    Icon(Icons.event),
    Icon(Icons.home),
    Icon(Icons.android),
    Icon(Icons.alarm),
    Icon(Icons.face),
    Icon(Icons.language),
  ];
  final Lessons = list();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Lessons.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              //const TabPageSelector(),
              Expanded(
                child: TabBarView(children: Lessons)
              ),
              Container(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final TabController controller =
                        DefaultTabController.of(context);
                    if (!controller.indexIsChanging) {
                      controller.animateTo(new DateTime.now().weekday - 1);
                    }
                  },
                  label: Text("OGGI"),
                  icon : Icon(Icons.calendar_today),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(accentColor(context)),
                  ),
                  )
                )              
            ],
          
          ),
        ),
      ),
    );
  }
}

mixin AgendaBlue400 {
}

List<Widget> getLesson(int day)
{
  List<Lesson> lesson = Status.register.getday(day);
  List<Widget> list = new List<Widget>();
  for(int i = 0; i< lesson.length; i++)
  {
    list.add(lessonCardInRow(lesson[i], i+1));
  }
  if(list.length == 0)
  {
    list.add( Column(
      children: [
        Center(
          child : IconText(
            Icon(Icons.search_off), 
            'Non ci sono lezioni oggi'
          )
        ),
      ],
    ));
  }
  return list;
}

List<Widget> list()
{  
  List<Widget> ret = [
    templatePage(1),
    templatePage(2),
    templatePage(3),
    templatePage(4),
    templatePage(5),
    templatePage(6),
    templatePage(7)
  ];
  return ret;
}

Widget templatePage(int day)
{
  return Scaffold(
    body: Column(
      children: <Widget>[
        Center(child : Header(WeekDay.daysITA()[day])),
        Column(children: getLesson(day),),
      ],
    ), 
  );
}