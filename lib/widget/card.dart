
import 'package:agenda_lezioni/utils/class/note.dart';
import 'package:flutter/material.dart';

import '../utils/class/lesson.dart';
import '../utils/colors.dart';
import '../utils/class/subject.dart';
import 'text.dart';

Card lessonCard(Lesson l, int i)
{
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    elevation: 5,
    shadowColor: AgendaBlue900,
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
        ),
      ],
    ),
  );
}

Card lessonCardCurrent(Lesson l, int i)
{
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    elevation: 5,
    shadowColor: AgendaBlue900,
    color: AgendaBlue300,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Text(i.toString()),
          title: Text(l.subject.name),
          subtitle: Text(
            l.interval,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
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
    shadowColor: AgendaBlue400,
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
Card subjectCard(Subject s)
{
  return Card(
    /*
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    */
    //elevation: 5,
    //shadowColor: AgendaBlue900,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          title: Text(s.name),
          subtitle: Text(
            s.note,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
}

Widget fixedNoteCard(Note n)
{
  return noteCard(n);
}

Widget dayNoteCard(Note n)
{
  return noteCard(n);
}

Widget volatileNoteCard(Note n)
{
  return noteCard(n);
}

Widget volatilDayNoteCard(Note n)
{
  return noteCard(n);
}

Widget eventCard(Note n)
{
  return noteCard(n);
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