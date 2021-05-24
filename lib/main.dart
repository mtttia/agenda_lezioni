library agenda;

import 'package:agenda_lezioni/utils/class/lesson.dart';
import 'package:agenda_lezioni/utils/class/note.dart';
import 'package:agenda_lezioni/utils/class/register.dart';
import 'package:agenda_lezioni/utils/class/subject.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'app.dart';
import 'utils/fileManager.dart';
import 'utils/status.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  FileManager.getFile().then((value){
    start(value);
  });

  //check();
  

}

void start(File file)
{
  /*
  file.deleteSync();
  Status.initalize();
  runApp(App());
  */
  
  if(!file.existsSync())
  {
    Status.initalize();
    runApp(App());
  }
  else
  {
    FileManager.load().then((value) => {
      startFormJson(value)
    });
  }
  
}

void startFormJson(String value)
{
  Status.initializeFromJson(value);
  runApp(App());
}

void check()
{
  DateTime day = new DateTime.now();
  Status.register = new Register(day.weekday);
  TimeOfDay duration = new TimeOfDay(hour: 1, minute: 0);
  TimeOfDay startTime = new TimeOfDay(hour: 12, minute: 0);
  TimeOfDay startTime1 = new TimeOfDay(hour: 10, minute: 0);
  TimeOfDay startTime2 = new TimeOfDay(hour: 11, minute: 0);
  int durationType = 0;
  int lessonType = 0;
  Subject subject = new Subject('Math', note:'note');
  Subject subject1 = new Subject('Computer scienze');
  Subject subject2 = new Subject('scienze');
  Status.register.subject.add(subject);
  Status.register.subject.add(subject1);
  Status.register.subject.add(subject2);
  Status.register.saturday.add(new Lesson(duration, startTime, lessonType, subject, durationType : durationType));
  Status.register.sunday.add(new Lesson(duration, startTime, lessonType, subject1,durationType :durationType));
  Status.register.monday.add(new Lesson(duration, startTime, lessonType, subject, durationType : durationType));
  Status.register.tuesday.add(new Lesson(duration, startTime, lessonType, subject1, durationType : durationType));
  Status.register.friday.add(new Lesson(duration, startTime, lessonType, subject, durationType : durationType));
  Status.register.friday.add(new Lesson(duration, startTime1, lessonType, subject1, durationType : durationType));
  Status.register.friday.add(new Lesson(duration, startTime2, lessonType, subject2, durationType : durationType));  
  Status.register.note.add(new FixedNote("Verifica di Matematica", "c'è la verifica di matematica", subject));
  Status.register.note.add(new Event("anather", "evento", subject1, new DateTime.now()));
  Status.register.note.add(new FixedNote("fissa", "fisso", subject2));

}