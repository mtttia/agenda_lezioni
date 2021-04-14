
import 'package:agenda_lezioni/utils/class/note.dart';
import 'package:flutter/material.dart';

import '../utils/class/lesson.dart';
import '../utils/colors.dart';
import '../utils/class/subject.dart';
import '../pages/subjectPage.dart';
import 'text.dart';

Widget lessonCard(Lesson l, int i)
{
  return LessonCard(l, i);
}

class LessonCard extends StatelessWidget
{
  LessonCard(this.l, this.i);
  Lesson l;
  int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      //shadowColor: AgendaBlue900,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: FontText(i.toString()),
            title: FontText(l.subject.name),
            subtitle: Text(
              l.interval,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: IconButton(
              onPressed: ()=> {Navigator.of(context).push(SubjectPageRoute(l.subject))},
              icon: Icon(Icons.trending_up),
            ),
          ),
        ],
      ),
    ),
    );
  }
  
}

Widget lessonCardCurrent(Lesson l, int i)
{
  return LessonCardCurrent(l, i);
}

class LessonCardCurrent extends StatelessWidget
{
  LessonCardCurrent(this.l, this.i);
  Lesson l;
  int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      //shadowColor: AgendaBlue900,
      color: SecondaryColor,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: FontText(i.toString()),
            title: FontText(l.subject.name),
            subtitle: Text(
              l.interval,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: IconButton(
              onPressed: ()=> {Navigator.of(context).push(SubjectPageRoute(l.subject))},
              icon: Icon(Icons.trending_up),
            ),
          ),
        ],
      ),
    ),
    );
  }
  
}


///card center in 80% space
Widget lessonCardInRow(Lesson l, int i)
{
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
        flex: 8,
        child: lessonCard(l, i)
      ),
      Expanded(
        flex: 1,
        child: Container(),
      ),
    ],
  );
}

Widget lessonCardCurrentInRow(Lesson l, int i)
{
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
        flex: 8,
        child: lessonCardCurrent(l, i)
      ),
      Expanded(
        flex: 1,
        child: Container(),
      ),
    ],
  );
}

//note

Card noteCard(Note n)
{
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    //shadowColor: AgendaBlue400,
    elevation: 5,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Text(n.subject.name),
          title: Text(n.name),
          subtitle: Text(
            n.text,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
}

Card noteCardNormal(Note n)
{
  return Card(
    //shadowColor: AgendaBlue400,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Text(n.subject.name),
          title: Text(n.name),
          subtitle: Text(
            n.text,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
}

///card center in 80% space
Widget noteCardInRow(Note n)
{
  return Row(
    children: [
      Expanded(
        flex: 1,
        child : Container(),
      ),
      Expanded(
        flex: 8,
        child: noteCard(n)
      ),
      Expanded(
      flex: 1,
      child : Container(),
      )
    ],
  );
}


//subject
Widget subjectCard(Subject s)
{
  return SubjectCard(s);
}

class SubjectCard extends StatelessWidget
{
  SubjectCard(this.s);
  Subject s;

  @override
  Widget build(BuildContext context) {
    return Card(    
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          title: Text(s.name),
          subtitle: Text(
            s.note,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
          trailing: IconButton(
            onPressed: ()=> {Navigator.of(context).push(SubjectPageRoute(s))},
            icon: Icon(Icons.trending_up),
          ),
        ),
      ],
    ),
    
  );
  }
  
}

Widget fixedNoteCard(Note n)
{
  return noteCardNormal(n);
}

Widget dayNoteCard(Note n)
{
  return noteCardNormal(n);
}

Widget volatileNoteCard(Note n)
{
  return noteCardNormal(n);
}

Widget volatilDayNoteCard(Note n)
{
  return noteCardNormal(n);
}

Widget eventCard(Note n)
{
  return noteCardNormal(n);
}

Widget subjectCardInRow(Subject s)
{
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(),
      ),
      Expanded(
        flex: 8,
        child: subjectCard(s)
      ),
      Expanded(
        flex: 1,
        child: Container(),
      ),
    ],
  );
}