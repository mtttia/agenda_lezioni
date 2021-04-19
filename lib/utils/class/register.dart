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
  TimeOfDay startTimeDefault;

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
      throw new Exception("day not valid: " + day.toString());
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
    startTimeDefault = new TimeOfDay(hour: 8, minute: 0);
    note = new List<Note>();
    subject = new List<Subject>();
  }

  Register.fromJson(Map<String, dynamic> json, int today)
  {
    currentDay = today;
    monday = json['monday'].length == 0 ? new List<Lesson>() : parseListLesson(json['monday']);
    tuesday = json['tuesday'].length == 0 ? new List<Lesson>() : parseListLesson(json['tuesday']);
    wednesday = json['wednesday'].length == 0 ? new List<Lesson>() : parseListLesson(json['wednesday']);
    thursday = json['thursday'].length == 0 ? new List<Lesson>() : parseListLesson(json['thursday']);
    friday = json['friday'].length == 0 ? new List<Lesson>() : parseListLesson(json['friday']);
    saturday = json['saturday'].length == 0 ? new List<Lesson>() : parseListLesson(json['saturday']);
    sunday = json['sunday'].length == 0 ? new List<Lesson>() : parseListLesson(json['sunday']);
    print(json['subject'].runtimeType.toString());
    subject = json['subject'].length == 0 ? new List<Subject>() : parseListSubject(json['subject']);
    note = json['note'].length == 0 ? new List<Note>() : parseListNote(json['note']);
    defaultDuration = MapTimeOfDay.decode(json['defaultDuration']);
    startTimeDefault = MapTimeOfDay.decode(json['startTimeDefault']);
  }

  List<Lesson> parseListLesson(List<dynamic> list)
  {
    List<Lesson> ret = new List<Lesson>();
    for(dynamic d in list)
    {
      ret.add(Lesson.fromJson(d));
    }
    return ret;
  }

  List<Note> parseListNote(List<dynamic> list)
  {
    List<Note> ret = new List<Note>();
    for(dynamic d in list)
    {
      ret.add(NoteManager.makeNoteFromMap(d));
    }
    return ret;
  }

  List<Subject> parseListSubject(List<dynamic> list)
  {
    List<Subject> ret = new List<Subject>();
    for(dynamic d in list)
    {
      ret.add(Subject.fromJson(d));
    }
    return ret;
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
      case 1 : return sortByStartTime(monday);
      case 2 : return sortByStartTime(tuesday);
      case 3 : return sortByStartTime(wednesday);
      case 4 : return sortByStartTime(thursday);
      case 5 : return sortByStartTime(friday);
      case 6 : return sortByStartTime(saturday);
      case 7 : return sortByStartTime(sunday);
    }
    throw new Exception("day not valid");
  }

  List<Lesson> getCurrentday()
  {
    return getday(currentDay);
  }

  List<Lesson> sortByStartTime(List<Lesson> l)
  {
    //bubble sort on startTime.hour
    Lesson temp;
    for(int i = 0; i < l.length; i++)
    {
      for(int j = 0; j < l.length - 1 - i; j++)
      {
        if(l[j].startTime.hour > l[j+1].startTime.hour)
        {
          temp = l[j];
          l[j] = l[j+1];
          l[j+1] = temp;
        }
      }
    }

    return l;
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
    for(Lesson les in l)
    {
      good = lessonIntegrationOk(lesson, les);
      if(!good)
        break;
    }
    
    return good;
  }

  bool lessonIntegrationOk(Lesson l1, Lesson l2)
  {
    TimeOfDay a = l2.startTime, b = l2.endTime, c = l1.startTime, d = l1.endTime;
    if(Comparer.comepareTimeOfDay(c, b) >= 0)
      return true;
    if(Comparer.comepareTimeOfDay(d, a) <= 0)
      return true;
    return false;
  }

  int getIdLesson(int day, Lesson l)
  {
    switch(day)
    {
      case 1 : return monday.indexOf(l);
      case 2 : return tuesday.indexOf(l);
      case 3 : return wednesday.indexOf(l);
      case 4 : return thursday.indexOf(l);
      case 5 : return friday.indexOf(l);
      case 6 : return saturday.indexOf(l);
      case 7 : return sunday.indexOf(l);
    }
  }

  void modifyLessonByLesson(int day, Lesson oldLesson, Lesson l)
  {
    int id = getIdLesson(day, oldLesson);
    //bool p = oldLesson == monday[0];
    //print(p.toString());
    print(monday.length);
    print('ID : $id');
    modifyLessonById(day, l, id);
  }

  ///modify a lesson given the day and the id
  void modifyLessonById(int day, Lesson l, int id)
  {
    try
    {
      switch(day)
      {
        case 1 : modifyLesson(monday, l, id, day); break;
        case 2 : modifyLesson(tuesday, l, id, day); break;
        case 3 : modifyLesson(wednesday, l, id, day); break;
        case 4 : modifyLesson(thursday, l, id, day); break;
        case 5 : modifyLesson(friday, l, id, day); break;
        case 6 : modifyLesson(saturday, l, id, day); break;
        case 7 : modifyLesson(sunday, l, id, day); break;
      }
    }catch(ex)
    {
      throw ex;
    }
  }

  //void ModifyLesson(DayOfWeek day, Lezione lVecchia, Lezione lNuova)
  void modifyLesson(List<Lesson> v, Lesson l, int id, int day)
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
        removeLesson(day, l);
        pushLesson(day, l);
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
    switch(day)
      {
        case 1 : remove(monday, l); break;
        case 2 : remove(tuesday, l); break;
        case 3 : remove(wednesday, l); break;
        case 4 : remove(thursday, l); break;
        case 5 : remove(friday, l); break;
        case 6 : remove(saturday, l); break;
        case 7 : remove(sunday, l); break;
      }
  }

  void remove(List<Lesson> v, Lesson l)
  {
    v.remove(l);
  }

  TimeOfDay getNextLessonTime(int day)
  {
    try{
      switch(day)
    {
      case 1: return monday[monday.length - 1].endTime;
      case 2: return tuesday[tuesday.length - 1].endTime;
      case 3: return wednesday[wednesday.length - 1].endTime;
      case 4: return thursday[thursday.length - 1].endTime;
      case 5: return friday[friday.length - 1].endTime;
      case 6: return saturday[saturday.length - 1].endTime;
      case 7: return sunday[sunday.length - 1].endTime;
    }
    }catch(ex)
    {
      return startTimeDefault;
    }
  }
  

  //MODIFICA MATERIA ========================================================================
  ///add a new Subject to the Subject List
  void addSubject(Subject s)
  {
    if(!subject.contains(s))
        subject.add(s);
    else
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

  Map<String, dynamic> getSubjectInfo(Subject s)
  {
    if(subject.contains(s))
    {
      return
      {
        'name' : s.name,
        'note' : s.note,
        'lessonNumber' : _getLessonsNumber(s),
        'dayWithLesson' : _dayWithLesson(s),
        'noteWithSubject' : _noteWithSubject(s),
      };
    }
    else
      throw new Exception('this subject not extist');
  }

  int _getLessonsNumber(Subject s)
  {
    int count = 0;
    count += _getLessonsNumberInList(monday, s);
    count += _getLessonsNumberInList(tuesday, s);
    count += _getLessonsNumberInList(wednesday, s);
    count += _getLessonsNumberInList(thursday, s);
    count += _getLessonsNumberInList(friday, s);
    count += _getLessonsNumberInList(saturday, s);
    count += _getLessonsNumberInList(sunday, s);
    return count;
  }
  int _getLessonsNumberInList(List<Lesson> l, Subject s)
  {
    int count = 0;
    for(Lesson les in l)
    {
      if(les.subject == s)
      {
        count++;
      }
    }
    return count;
  }

  List<List<int>> _dayWithLesson(Subject s)
  {
    List<List<int>> days = new List<List<int>>();
    if(_getLessonsNumberInList(monday, s) > 0){days.add([1, _getLessonsNumberInList(monday, s)]);}
    if(_getLessonsNumberInList(tuesday, s) > 0){days.add([2, _getLessonsNumberInList(tuesday, s)]);}
    if(_getLessonsNumberInList(wednesday, s) > 0){days.add([3, _getLessonsNumberInList(wednesday, s)]);}
    if(_getLessonsNumberInList(thursday, s) > 0){days.add([4, _getLessonsNumberInList(thursday, s)]);}
    if(_getLessonsNumberInList(friday, s) > 0){days.add([5, _getLessonsNumberInList(friday, s)]);}
    if(_getLessonsNumberInList(saturday, s) > 0){days.add([6, _getLessonsNumberInList(saturday, s)]);}
    if(_getLessonsNumberInList(sunday, s) > 0){days.add([7, _getLessonsNumberInList(sunday, s)]);}
    return days;
  }

  List<Note> _noteWithSubject(Subject s)
  {
    List<Note> list = new List<Note>();
    for(Note n in note)
    {
      if(n.subject == s)
        list.add(n);
    }
    return list;
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
        if(sameDateTime(e.day, d))
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

  bool sameDateTime(DateTime d1, DateTime d2)
  {
    if(d1.day == d2.day && d1.month == d2.month && d1.year == d2.year)
      return true;
    return false;
  }

  ///add a note to the list
  void addNote(Note n)
  {
    if(!note.contains(n))
    {
      note.add(n);
    }
    else
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
  
  List<FixedNote> get fixedNote
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


  List<DayNote> get dayNote
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

  List<VolatileNote> get volatilNote
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

  List<VolatilDayNote> get volatilDayNote
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

  List<Event> get event
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
      'startTimeDefault' : MapTimeOfDay.map(startTimeDefault),
    };
    
  }

}