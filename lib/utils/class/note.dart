library agenda;
import 'package:flutter/rendering.dart';

import 'IMappable.dart';
import 'materia.dart';

abstract class Note implements IMappable
{
  String _name;
  String get name{
    return _name;
  }
  set name(String value)
  {
    if(value.isEmpty)
    {
      throw new Exception("Name not valid");
    }
    _name = value;
  }
  String _text;
  String get text{
    return _text;
  }
  set text(String value)
  {
    if(value.isEmpty)
    {
      throw new Exception("Text not valid");
    }
    _text = value;
  }

  Subject subject;

  Note(String n, String t, Subject s)
  {
    try
    {
      name = n;
      text = t;
      subject = s;
    }catch(ex)
    {
      throw ex;
    }
  }

  @override
  String toString() {
    return super.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    return{
      "name" : name,
      "text" : text,
      "subject" : subject
    };
  }
}

//classi figlie

class FixedNote extends Note
{
  FixedNote(String n, String t, Subject s) : super(n, t, s){}
  static const String type = "Fixed";

  @override
  Map<String, dynamic> toMap() {
    return{
      "type" : type,
      "name" : name,
      "text" : text,
      "subject" : subject
    };
  }
}

class VolatileNote extends Note
{
  DateTime deadline;
  static const String type = "Volatile";

  VolatileNote(String n, String t, Subject s, DateTime d) : super(n, t, s)
  {
    deadline = d;
  }

  bool valid()
  {
    DateTime now = new DateTime.now();
    if(deadline.compareTo(now) < 0)
    {
      return false;
    }
    return true;
  }

  @override
  Map<String, dynamic> toMap() {
    return{
      "type" : type,
      "name" : name,
      "text" : text,
      "deadline" : getMapFromDatetime(deadline),
      "subject" : subject
    };
  }
}

class DayNote extends Note
{
  int weekDay;
  static const String type = "Day";

  DayNote(String n, String t, Subject s,  int d ) : super(n, t, s)
  {
    weekDay = d;
  }

  @override
  Map<String, dynamic> toMap() {
    return{
      "type" : type,
      "name" : name,
      "text" : text,
      "weekDay" : weekDay,
      "subject" : subject
    };
  }
}

class VolatilDayNote extends VolatileNote
{
  int weekDay;
  static const String type = "VolatilDay";

  VolatilDayNote(String n, String t, Subject s, DateTime d, int day) : super(n, t, s, d)
  {
    weekDay = day;
  }

  @override
  Map<String, dynamic> toMap() {
    return{
      "type" : type,
      "name" : name,
      "text" : text,
      "deadline" : deadline,
      "weekDay" : weekDay,
      "subject" : subject
    };
  }
}

class Event extends Note
{
  DateTime day;
  static const String type = "Event";

  Event(String n, String t, Subject s, DateTime d) : super(n, t, s)
  {
    day = d;
  }

  @override
  Map<String, dynamic> toMap() {
    return{
      "type" : type,
      "name" : name,
      "text" : text,
      "day" : getMapFromDatetime(day),
      "subject" : subject
    };
  }
}

abstract class NoteManager
{
  static Note MakeNoteFromMap(Map<String, dynamic> map)
  {
    String name = map['name'];
    String text = map['text'];
    Subject subject = Subject.FromMap(map['subject']);
    switch(map['type'])
    {
      case 'Fixed':
        //creat a fixed notes
        FixedNote n = new FixedNote(name, text, subject);
        return n;
      case 'Volatile':
        DateTime day = getDatetime(map['deadline']);
        VolatileNote n = new VolatileNote(name, text, subject, day);
        return n;
      case 'Day':
        int day = map['weekDay'];
        DayNote n = new DayNote(name, text, subject, day);
        return n;
      case 'VolatilDay':
        DateTime deadline = getDatetime(map['deadline']);
        int day = map['weekDay'];
        VolatilDayNote n = new VolatilDayNote(name, text, subject, deadline, day);
        return n;
      case 'Event':
        DateTime day = getDatetime(map['day']);
        Event n = new Event(name, text, subject, day);
        return n;
    }
    throw new Exception('internal error : note type not found [deserialization]');
  }
}

Map<String, dynamic> getMapFromDatetime(DateTime d)
{
  return{
    "day" : d.day,
    "month" : d.month,
    "year" : d.year
  };
}

DateTime getDatetime(Map<String, dynamic> map)
{
  DateTime date = new DateTime(map['day'], map['month'], map['year']);
  return date;
}