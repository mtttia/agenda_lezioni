library agenda;

import 'package:flutter/material.dart';
import '../../utils/class/subject.dart';
import '../../widget/text.dart';
import '../../utils/colors.dart';
import '../../utils/status.dart';
import '../../utils/class/lesson.dart';
import '../../widget/dialog.dart';
import '../../widget/buttonStyle.dart';

class AddLessonRoute extends MaterialPageRoute<void>
{
  AddLessonRoute(Function() callback, int day, {bool modify = false, Lesson oldLesson}) : super(builder: (BuildContext context)
  {
    return AddLesson(callback, day, modify:modify, oldLesson: oldLesson,);
  });
}

// ignore: must_be_immutable
class AddLesson extends StatefulWidget
{
  AddLesson(this.callback, this.day, {this.modify = false, this.oldLesson});
  Function() callback;
  bool modify;
  Lesson oldLesson;
  int day;

  _AddLesson createState() => _AddLesson(callback, day, modify: modify, oldLesson: oldLesson);
}

class _AddLesson extends State<AddLesson>
{
  _AddLesson(this.callback, this.day, {this.modify = false, this.oldLesson})
  {
    duration = _duration;
    _startTime = Status.register.getNextLessonTime(this.day);
    startTime = _startTime;
    _selectedType = 'teoria';
    lessonTypeS = _selectedType;
    if(modify)
    {
      //I set all the parameters to oldLesson parameters
      _startTime = oldLesson.startTime;
      startTime = oldLesson.startTime;
      _duration = oldLesson.duration;
      duration = oldLesson.duration;
      _subjectSelected = oldLesson.subject;
      subject = oldLesson.subject;
      _selectedType = oldLesson.lessonType == 0 ? 'teoria' : 'pratica';
      lessonTypeS = oldLesson.lessonType == 0 ? 'teoria' : 'pratica';
    }
  }
  bool modify;
  Lesson oldLesson;
  Function() callback;
  int day;
  static const lessonTypes = <String>[
    'teoria',
    'pratica',
  ];

  final List<DropdownMenuItem<String>> _dropDownLessonTypes = lessonTypes
    .map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    )
    .toList();

  String _selectedType;

  TimeOfDay _startTime;
  TimeOfDay _duration = Status.register.defaultDuration;
  Subject _subjectSelected;

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Aggiungi lezione'),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: ()=>navigatorPop(context, modify: modify, oldLesson: oldLesson, day: day, callback: callback)
        )
      ),
      body: ListView(
        children: [
          ListTile(
            title: FontText("Seleziona la materia"),
            trailing: DropdownButton(
              items: getDropdownSubject(),
              value: _subjectSelected,
              onChanged: (Subject value)=>{
                setState(()=>{
                  subject = value,
                  _subjectSelected = value
                })
              }
            ),
          ),
          ListTile(
            title: TextButton.icon(
              icon: Icon(Icons.schedule),
              label: FontText('ora di inizio'),
              style: textButtonStyle(),
              onPressed: ()=>{
                getTimePicker(context, 'seleziona l\'ora di inizio della lezione', startTime: _startTime).then((value) => {
                  setState(()=>{
                    startTime = value,
                    _startTime = value
                  })
                })
              },
            ),
            trailing: FontText(_startTime == null ? '' : _startTime.hour.toString() + ' : '+ _startTime.minute.toString()),
          ),
          ListTile(
            title: TextButton.icon(
              icon: Icon(Icons.schedule),
              label: FontText('durata'),
              style: textButtonStyle(),
              onPressed: ()=>{
                getTimePicker(context, 'seleziona la durata della lezione', startTime: _duration).then((value) => {
                  setState(()=>{
                    duration = value,
                    _duration = value
                  })
                })
              },
            ),
            trailing: FontText(_duration == null ? '' : _duration.hour.toString() + ' : '+ _duration.minute.toString()),
          ),
          ListTile(
            title: FontText('tipo di lezione'),
            trailing: DropdownButton(
              value: _selectedType,
              onChanged: (String value) {                
                setState(() {
                  lessonTypeS = value;
                  _selectedType = value;
                });
              },
              items: _dropDownLessonTypes,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          addLesson_click(context, callback, day, modify : modify, oldLesson: oldLesson)
        },
        icon: Icon(Icons.add), label: Text('Aggiungi lezione'),
        backgroundColor: accentColor(context),
      )
    );
  }
  
}

//value to know to create a lesson
Subject subject;
TimeOfDay startTime;
TimeOfDay duration;
String lessonTypeS;

void addLesson_click(BuildContext context, Function() callback, int day, {bool modify = false, Lesson oldLesson})
{
  try
  {
    int lessonType = lessonTypeS == 'teoria' ? 0 : 1;
    Lesson toAdd = new Lesson(duration, startTime, lessonType, subject);
    if(modify)
    {
      Status.register.modifyLessonByLesson(day, oldLesson, toAdd);
    }
    else
    {
      Status.register.pushLesson(day, toAdd);
    }
    callback();
    Navigator.of(context).pop();
    Status.save();
  }catch(ex)
  {
    dialog(context, "attenzione", ex.toString());
  }
}


List<DropdownMenuItem<Subject>> getDropdownSubject()
{
  List<DropdownMenuItem<Subject>> list = new List<DropdownMenuItem<Subject>>();
  for(Subject s in Status.register.subject)
  {
    list.add(DropdownMenuItem<Subject>(
      child: Text(s.name),
      value: s,
    ));
  }
  return list;
}

Future<TimeOfDay> getTimePicker(BuildContext context, String info, {TimeOfDay startTime})
{
  DateTime now = new DateTime.now();
  TimeOfDay t = startTime == null ? new TimeOfDay(hour: now.hour, minute: now.minute) : startTime;
  return showTimePicker(
    context: context, 
    initialTime: t,
    helpText: info,    
  );
}

void navigatorPop(BuildContext context, {bool modify : false, int day, Lesson oldLesson, Function() callback})
{
  try
  {
    if(modify)
    {
      Status.register.pushLesson(day, oldLesson);
      callback();
    }
    Navigator.of(context).pop();
  }
  catch(ex)
  {
    throw ex;
  }
}