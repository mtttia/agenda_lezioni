library agenda;

import 'dart:convert';

import 'package:agenda_lezioni/utils/class/MapTimeOfDay.dart';
import 'package:agenda_lezioni/utils/class/subject.dart';
import 'package:agenda_lezioni/utils/class/note.dart';
import 'package:flutter/material.dart';
import 'note.dart';
import 'lesson.dart';

class Register
{
  List<Lesson> monday;
  List<Lesson> tuesday;
  List<Lesson> wednesday;
  List<Lesson> thursday;
  List<Lesson> friday;
  List<Lesson> saturday;
  List<Lesson> sunday;

  List<Subject> subject;

  List<Note> note;

  TimeOfDay defaultDuration;

  //ignore
  int _currentDay;
  int get currentDay
  {
    return _currentDay;
  }
  set currentDay(int day)
  {
    if(!(day >= 1 && day <= 7))
    {
      throw new Exception("day not valid");
    }
    _currentDay = day;
  }


  Register(int today)
  {
    currentDay = today;
    tuesday = List<Lesson>();
    wednesday = List<Lesson>();
    thursday = List<Lesson>();
    friday = List<Lesson>();
    monday = List<Lesson>();
    saturday = List<Lesson>();
    sunday = List<Lesson>();
    defaultDuration = new TimeOfDay(hour: 1, minute: 0);
    note = new List<Note>();
    subject = new List<Subject>();
  }

  Register.fromJson(Map<String, dynamic> json, int today)
  {
    currentDay = today;
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
    subject = json['subject'];
    note = json['note'];
    defaultDuration = MapTimeOfDay.decode(json['defaultDuration']);
  }

  void checkVolatilNote()
  {
    List<int> toRemove = new List<int>();
    for(int i = 0; i < note.length; i++)
    {
      bool delete = false;
      if(note[i] is VolatileNote)
      {
        VolatileNote temp = note[i] as VolatileNote;
        if(!temp.valid())
        {
          delete = true;
        }
      }
      else if(note[i] is VolatilDayNote)
      {
        VolatilDayNote temp = note[i] as VolatilDayNote;
        if(!temp.valid())
        {
          delete = true;
        }
      }
      else if(note[i] is Event)
      {
        Event temp = note[i] as Event;
        if(!temp.valid())
        {
          delete = true;
        }
      }

      if(delete)
      {
        toRemove.add(i);
      }
    }

    for(int a in toRemove)
    {
      note.removeAt(a);
    }
  }

  //metods
  List<Lesson> getday(int day)
  {
    switch(day)
    {
      case 1 : return monday;
      case 2 : return tuesday;
      case 3 : return wednesday;
      case 4 : return thursday;
      case 5 : return friday;
      case 6 : return saturday;
      case 7 : return sunday;
    }
    throw new Exception("day not valid");
  }

  List<Lesson> getCurrentday()
  {
    return getday(currentDay);
  }

  //ITERATION WITH SET TIME ========================================================
  void pushLesson(int day, Lesson l)
  {
    switch (day)
    {
      case 1 : addLesson(monday, l); break;
      case 2 : addLesson(tuesday, l); break;
      case 3 : addLesson(wednesday, l); break;
      case 4 : addLesson(thursday, l); break;
      case 5 : addLesson(friday, l); break;
      case 6 : addLesson(saturday, l); break;
      case 7 : addLesson(sunday, l); break;
    }
  }

  void addLesson(List<Lesson> v, Lesson l)
  {
    if(validLesson(v, l))
    {
      //lesson can be added
      v.add(l);
      v.sort();
    }
    else
    {
      throw new Exception("lesson time not valid");
    }
  }

  bool validLesson(List<Lesson> l, Lesson lesson)
  {
    
    bool good = true;
    //first condition: the start time and the end time must be out of each range
    for(int i = 0; i < l.length && good; i++)
    {
        if(!(Comparer.comepareTimeOfDay(lesson.startTime, l[i].startTime) < 0 && Comparer.comepareTimeOfDay(lesson.startTime, l[i].endTime) >= 0))
        {
            good = false;
        }
        else
        {
          
          if(!(Comparer.comepareTimeOfDay(lesson.endTime, l[i].startTime) < 0 && Comparer.comepareTimeOfDay(lesson.endTime, l[i].endTime) >= 0))
          {
              good = false;
          }
        }
    }

    if(good)
    {
        //second condition: the start time of each lesson must be out of the lesson range
        for(int i = 0; i < l.length && good; i++)
        {
          if(!(Comparer.comepareTimeOfDay(l[i].startTime, lesson.startTime) < 0 && Comparer.comepareTimeOfDay(l[i].startTime, lesson.endTime) >= 0))
          {
              good = true;
          }
        }
    }

    return good;
  }

  ///modify a lesson given the day and the id
  void modifyLessonById(int day, Lesson l, int id)
  {
    try
    {
      switch(day)
      {
        case 1 : modifyLesson(monday, l, id); break;
        case 2 : modifyLesson(tuesday, l, id); break;
        case 3 : modifyLesson(wednesday, l, id); break;
        case 4 : modifyLesson(thursday, l, id); break;
        case 5 : modifyLesson(friday, l, id); break;
        case 6 : modifyLesson(saturday, l, id); break;
        case 7 : modifyLesson(sunday, l, id); break;
      }
    }catch(ex)
    {
      throw ex;
    }
  }
  //void ModifyLesson(DayOfWeek day, Lezione lVecchia, Lezione lNuova)
  void modifyLesson(List<Lesson> v, Lesson l, int id)
  {
    try
    {
      if(id < 0)
      {
        throw new Exception('id not found');
      }
      //check if the lesson can be added
      List<Lesson> temp = v;
      temp.removeAt(id);
      if(validLesson(temp, l))
      {
        //modify is accepted
        v.removeAt(id);
        addLesson(v, l);
      }
      else
      {
        throw new Exception('new lesson\'s time not valid');
      }
    }
    catch(ex)
    {
      throw ex;
    }
  }

  ///remove a lesson from a day
  void removeLesson(int day, Lesson l)
  {

  }

  void remove(List<Lesson> v, Lesson l)
  {
    v.remove(l);
  }

  //MODIFICA MATERIA ========================================================================
  ///add a new Subject to the Subject List
  void addSubject(Subject s)
  {
    if(!subject.contains(s))
        subject.add(s);
    throw new Exception("this subject already exists");
  }

  ///modify an existent Subject
  void modifySubject(Subject oldS, Subject newS)
  {
    subject.remove(oldS);
    addSubject(newS);
    //change the subject in all the list
    modifySubjectInList(monday, oldS, newS);
    modifySubjectInList(tuesday, oldS, newS);
    modifySubjectInList(wednesday, oldS, newS);
    modifySubjectInList(thursday, oldS, newS);
    modifySubjectInList(friday, oldS, newS);
    modifySubjectInList(saturday, oldS, newS);
    modifySubjectInList(sunday, oldS, newS);
  }

  void modifySubjectInList(List<Lesson> l, Subject o, Subject n)
  {
    for(int i = 0; i < l.length; i++)
    {
      if(l[i].subject == o)
      {
        l[i].subject = n;
      }
    }
  }

  ///remove a subject from the List of subject
  void removeSubject(Subject toRemove)
  {
    subject.remove(toRemove);
    //remove the lesson from all the list
    removeSubjectInList(monday, toRemove);
    removeSubjectInList(tuesday, toRemove);
    removeSubjectInList(wednesday, toRemove);
    removeSubjectInList(thursday, toRemove);
    removeSubjectInList(friday, toRemove);
    removeSubjectInList(saturday, toRemove);
    removeSubjectInList(sunday, toRemove);
  }

  void removeSubjectInList(List<Lesson> l, Subject canc)
  {
    for(int i = 0; i < l.length; i++)
    {
      if(l[i].subject == canc)
      {
        l.removeAt(i);
      }
    }
  }

  //ITERAZIONI CON LE NOTE
  ///return all the note about a data
  List<Note> getNote(DateTime d)
  {
    List<Note> ret = new List<Note>();
    for(Note n in note)
    {
      if(n is FixedNote)
      {
        ret.add(n);
      }
      else if(n is DayNote)
      {
        DayNote temp = n as DayNote;
        
        if(temp.weekDay ==  d.day)
        {
          ret.add(n);
        }
      }
      else if(n is VolatileNote)
      {        
        ret.add(n);
      }
      else if(n is VolatilDayNote)
      {
        VolatilDayNote temp = n as VolatilDayNote;

        if(temp.weekDay ==  d.day)
        {
          ret.add(n);
        }
      }
      else if(n is Event)
      {
        Event e = n;
        if(e.day == d)
        {
          ret.add(e);
        }
      }
    }
    return ret;
  }

  ///return the note about Datetime now
  List<Note> getTodayNote()
  {
    return getNote(DateTime.now());
  }

  ///add a note to the list
  void addNote(Note n)
  {
    if(!note.contains(n))
    {
      note.add(n);
    }
    throw new Exception('this note already exists');
  }

  ///modify a note on the list
  modifyNote(Note oldNote, Note newNote)
  {
    try
    {
      removeNote(oldNote);
      addNote(newNote);
    }catch(ex)
    {
      throw ex;
    }
  }

  ///remove a note frome the list
  void removeNote(Note toRemove)
  {
    note.remove(toRemove);
  }

  ///get all the notes
  
  List<FixedNote> getFixedNote()
  {
    List<FixedNote> l = new List<FixedNote>();
    for(Note n in note)
    {
      if(n is FixedNote) 
      {
        FixedNote temp = n;
        l.add(temp);
      }
    }
    return l;
  }

  List<DayNote> getDayNote()
  {
    List<DayNote> l = new List<DayNote>();
    for(Note n in note)
    {
      if(n is DayNote) 
      {
        DayNote temp = n;
        l.add(temp);
      }
    }
    return l;
  }

  List<VolatileNote> getVolatilNote()
  {
    List<VolatileNote> l = new List<VolatileNote>();
    for(Note n in note)
    {
      if(n is VolatileNote) 
      {
        VolatileNote temp = n;
        l.add(temp);
      }
    }
    return l;
  }

  List<VolatilDayNote> getVolatilDayNote()
  {
    List<VolatilDayNote> l = new List<VolatilDayNote>();
    for(Note n in note)
    {
      if(n is VolatilDayNote) 
      {
        VolatilDayNote temp = n;
        l.add(temp);
      }
    }
    return l;
  }

  List<Event> getEvent()
  {
    List<Event> l = new List<Event>();
    for(Note n in note)
    {
      if(n is Event) 
      {
        Event temp = n;
        l.add(temp);
      }
    }
    return l;
  }

  //DEFAULT DURATION =======================================================

  void setDefaultDuration(TimeOfDay duration)
  {
    try
    {
      if(duration != defaultDuration)
      {
        defaultDuration = duration;
        updateDfDuration(monday);
        updateDfDuration(tuesday);
        updateDfDuration(wednesday);
        updateDfDuration(thursday);
        updateDfDuration(friday);
        updateDfDuration(saturday);
        updateDfDuration(sunday);
      }
    }catch(ex)
    {
      throw ex;
    }
  }

  void updateDfDuration(List<Lesson> l)
  {
    for(int i = 0; i < l.length; i++)
    {
      if(l[i].durationType == 0)//default
      {
        //I modify it
        l[i].duration = defaultDuration;
        //check the beginning of the next lesson
        if(i != l.length -1 )//if lesson is not over
        {
          //I carry on all the hours until they go well
          TimeOfDay time = l[i].endTime;
          int a = 1;
          while(Comparer.comepareTimeOfDay(time, l[i+1].startTime) > 0)
          {
            //I change the hours to the startTime of l[i+a]
            l[i+a].startTime = Lesson.sumTimeOfDay(l[i+a].startTime, time.hour, time.minute);
            a++;
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'monday' : monday,
      'tuesday' : tuesday,
      'wednesday' : wednesday,
      'thursday' : thursday,
      'friday' : friday,
      'saturday' : saturday,
      'sunday' : sunday,
      'subject' : subject,
      'note': note,
      'defaultDuration' : MapTimeOfDay.map(defaultDuration),
    };
    
  }

}