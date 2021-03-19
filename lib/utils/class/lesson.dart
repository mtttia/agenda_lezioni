library agenda;

import 'package:flutter/material.dart';
import 'subject.dart';
import 'MapTimeOfDay.dart';

/*
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
*/

class Comparer
{
  static int comepareTimeOfDay(TimeOfDay t1, TimeOfDay t2)
  {
    if(_timeOfDayToDouble(t1) > _timeOfDayToDouble(t2))
      return 1;
    else if(_timeOfDayToDouble(t1) == _timeOfDayToDouble(t2))
      return 0;
    return -1;
  }
  
  static double _timeOfDayToDouble(TimeOfDay time)
  {
    return time.hour + time.minute/60.0;
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
}

class Lesson
{
  TimeOfDay duration;
  TimeOfDay startTime;
  TimeOfDay get endTime
  {
    return sumTimeOfDay(startTime, duration.hour, duration.minute);
  }
  String get interval
  {
    return "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}";
  }
  int durationType; //0 = Default, 1 = Customized
  int lessonType; //0 = Theory, 1 = Practice
  Subject subject;

  Lesson(this.duration, this.startTime, this.durationType, this.lessonType, this.subject);
  Lesson.fromJson(Map<String, dynamic> json)
  {
    duration = MapTimeOfDay.decode(json['duration']);
    startTime = MapTimeOfDay.decode(json['startTime']);
    durationType = json['durationType'];
    lessonType = json['lessonType'];
    subject = json['subject'];
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

  String get stringStartTime
  {
    return "${startTime.hour} : ${startTime.minute}";
  }

  Map<String, dynamic> toJson() {
    return 
    {
      "duration" : MapTimeOfDay.map(duration),
      "startTime" : MapTimeOfDay.map(startTime),
      "durationType" : durationType,
      "lessonType" : lessonType,
      "subject" : subject.toJson()
    };
  }

  @override
  bool operator ==(other) => equals(this, other);

  bool equals(Lesson first, second)
  {
    if(second is Lesson)
    {
      Lesson l = second;
      if(first.startTime == l.startTime && first.endTime == l.endTime)
        return true;
      return false;
    }
    return false;
  }


}
