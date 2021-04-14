library agenda;

import 'package:flutter/material.dart';
import 'package:agenda_lezioni/utils/status.dart';
import '../../utils/class/lesson.dart';
import '../../utils/class/subject.dart';
import '../../utils/class/note.dart';
import '../../utils/class/weekDay.dart';
import '../../widget/card.dart';
import '../../widget/text.dart';
import '../../utils/colors.dart';
import 'addLesson.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class SetTimeRoute extends MaterialPageRoute<void>
{
  SetTimeRoute(Function() callback) : super(builder: (BuildContext context)
  {
    return SetTime(callback);
  });
}

class SetTime extends StatefulWidget
{
  SetTime(this.callback);
  Function() callback;

  _SetTimeState createState() => _SetTimeState(callback);
}

class _SetTimeState extends State<SetTime>
{
  _SetTimeState(this.callback);
  Function() callback;

  final Lessons = list();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Imposta orario'),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: ()=>Navigator.of(context).pop(),
        )
      ),
      body: DefaultTabController(
      length: Lessons.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const TabPageSelector(),
              Expanded(
                child: TabBarView(children: Lessons)
              ),            
            ],
          
          ),
        ),
      ),
    ),
    );
  }
  
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
    TemplatePage(1),
    TemplatePage(2),
    TemplatePage(3),
    TemplatePage(4),
    TemplatePage(5),
    TemplatePage(6),
    TemplatePage(7)
  ];
  return ret;
}

class TemplatePage extends StatefulWidget
{
  int day;
  TemplatePage(this.day) : assert(day > 0, day < 8);

  _TemplatePage createState() => _TemplatePage(day);
}

class _TemplatePage extends State<TemplatePage>
{
  _TemplatePage(this.day)
  {
    _list = Status.register.getday(day);
  }
  int day;
  List<Lesson> _list;
  Lesson _currentLesson;
  List<Slidable> _items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
              Center(child: Header(WeekDay.daysITA()[day])),
              SizedBox(height: 50),
              Expanded(
                flex: 2,
                child: ListView(children: getListLesson(),)
              )
            ],),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          Navigator.of(context).push(AddLessonRoute(()=>{setState(()=>{})}, day))
        },
        icon: Icon(Icons.add), label: Text('Aggiungi lezione'),
        backgroundColor: accentColor(context),
        )
    );
  }

  void deleteLesson(Lesson l, int day)
  {
    Status.register.removeLesson(day, l);
    setState(() {
      _list.remove(l);
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(l.subject.name + ' rimossa'),
        action: SnackBarAction(
          label: 'UNDO', 
          onPressed: (){
            setState(() {
              _list.add(l);
            });
            Status.save();
          }
        ),
      )
    );
    Status.save();
    
  }

  void modifyLesson(Lesson l)
  {
    Navigator.of(context).push(AddLessonRoute(()=>{setState(()=>{})}, day, modify: true, oldLesson: l));
    setState(() {});
  }

  List<Widget> getListLesson()
  {
    List<Widget> list = new List<Widget>();
    for(int i = 0; i < _list.length; i++)
    {
      list.add(getLesson(_list[i], i+1));
    }
    return list;
  }

  Slidable getLesson(Lesson n, int i)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifyLesson(n),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteLesson(n, i),
        ),
      ],
      child: lessonCard(n, i)
    );
  }
  
}
