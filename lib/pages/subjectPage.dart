library agenda;

import 'package:flutter/material.dart';
import '../utils/class/subject.dart';
import '../utils/status.dart';
import '../utils/class/weekDay.dart';
import '../utils/class/note.dart';
import '../widget/text.dart';
import '../widget/card.dart';

class SubjectPageRoute extends MaterialPageRoute<void>
{
  SubjectPageRoute(Subject s) : super(builder: (BuildContext context)
  {
    return Scaffold(
      body: SubjectPage(s),
    );
  });
}


class SubjectPage extends StatelessWidget
{
  SubjectPage(Subject s) : assert(s != null)
  {
    map = Status.register.getSubjectInfo(s);
  }
  Map<String, dynamic> map;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Materia'),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: ()=>Navigator.of(context).pop(),
        )
      ),
      body : ListView(
        children: [
          Header(map['name']),
          Padding(
            padding: EdgeInsets.all(27.0),
            child: FontText(map['note']),
          ),
          SizedBox(height: 30),
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              title: Subtitle(map['lessonNumber'].toString() + ' lezioni'),
              subtitle: makeDayWithLesson(map['dayWithLesson']),              
            ),            
            elevation : 0,
            
          ),
          SizedBox(height: 15),
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              title: Subtitle('note'),          
              subtitle: getNote(map['noteWithSubject']),
            ),
            elevation : 0,
          )
        ],
      )
    );
  }
  
}

Column makeDayWithLesson(List<List<int>> list)
{
  List<Widget> ret = new List<Widget>();
  for(List<int> l in list)
  {
    ret.add(makeLesson(l));
  }
  return Column(children: ret);
}

Widget makeLesson(List<int> list)
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
          title: Text(WeekDay.daysITA()[list[0]]),
          subtitle: Text(
            list[1].toString(),
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
}

Column getNote(List<Note> list)
{
  List<Widget> ret = new List<Widget>();
  for(Note n in list)
  {
    ret.add(noteCardNormal(n));
  }
  return Column(children : ret);
}