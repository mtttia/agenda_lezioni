library agenda;

import 'package:flutter/material.dart';
import 'materia.dart';

enum DurationType
{
  Default,
  Customized
}
enum LessonType
{
  Theory,
  Practice
}

class Lesson implements Comparable<Lesson>
{
  TimeOfDay duration;
  TimeOfDay startTime;
  TimeOfDay get endTime
  {
    return sumTimeOfDay(startTime, duration.hour, duration.minute);
  }
  DurationType durationType;
  LessonType lessonType;
  Subject subject;
  int _id;
  set id(int value)
  {
    if(value < 0)
    {
      throw new Exception("id not valid");
    }
    _id = value;
  }
  int get id
  {
    return _id;
  }

  
  static TimeOfDay sumTimeOfDay(TimeOfDay time, int hours, int minutes)
  {
    int newHours = time.hour + hours;
    int newMinutes = time.minute + minutes;
    if(newMinutes > TimeOfDay.minutesPerHour)
    {
      newMinutes -= TimeOfDay.minutesPerHour;
      newHours++;
    }
    if(newHours > 23)
    {
      newHours -= 23; //hours restart by 1
    }
    return new TimeOfDay(hour: newHours, minute: newMinutes);
  }

  @override
  int compareTo(Lesson other) {
    
  }

}

