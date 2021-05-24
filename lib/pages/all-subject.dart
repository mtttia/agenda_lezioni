library agenda;

import 'package:flutter/material.dart';
import '../utils/class/subject.dart';
import '../utils/status.dart';
import '../widget/card.dart';
import '../widget/text.dart';
import '../utils/colors.dart';
import 'add-subject.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllSubject extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header('Lezioni'),
          SizedBox(height: 20,),
          Expanded(flex: 1,
            child: SubjectList(),
          ),
        ],
      )
    );
  }
  
}

class SubjectList extends StatefulWidget {
  const SubjectList({Key key}) : super(key: key);

  @override
  _SubjectListState createState() {
    return _SubjectListState();
  }

}

class _SubjectListState extends State<SubjectList> {

  List<Subject> _subject = Status.register.subject;
  List<Slidable> _items;
  Subject _currentSubject = null;


  @override
  Widget build(BuildContext context) {
    print(Status.register.subject.length);
    return Scaffold(
      body: Padding(
        child: ListView(children: getListSubject()),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          Navigator.of(context).push(AddSubjectRoute(()=>{setState(()=>{})}))
        },
        icon: Icon(Icons.add), label: Text('Aggiungi lezione'),
        backgroundColor: accentColor(context),
        )
    );
  }


  
  void deleteSubject(BuildContext context, Subject s)
  {
    
    setState(() {
      Status.register.removeSubject(s);
    });
    Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(s.name + ' rimossa.'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {                        
          setState(() => this._subject.add(s));
          Status.save();
        },
        
      ),
    ),
    );
    Status.save();
  }

  void modifySubject(Subject s)
  {
    Navigator.of(context).push(AddSubjectRoute(()=>{setState(()=>{})}, modify: true, oldSubject: s));
    setState(() => {});
  }

  List<Widget> getListSubject()
  {
    List<Widget> list = new List<Widget>();
    for(Subject s in _subject)
    {
      list.add(getSubject(s));
    }
    return list;
  }

  Slidable getSubject(Subject s)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      //actions: mainActions, // swipe right
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifySubject(s),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteSubject(context, s),
        ),
      ], //swipe left
      child: SubjectCard(s),
    );
  }
}



