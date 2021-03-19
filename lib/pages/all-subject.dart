library agenda;

import 'package:flutter/material.dart';
import '../utils/class/subject.dart';
import '../utils/status.dart';
import '../widget/card.dart';
import '../widget/text.dart';
import '../utils/colors.dart';

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
  State<StatefulWidget> createState() {
    return _SubjectListState();
  }
}

class _SubjectListState extends State<SubjectList> {

  List<Subject> _list = Status.register.subject;
  Subject _currentSubject = null;

  @override
  Widget build(BuildContext context) {
    print(Status.register.subject.length);
    return Scaffold(
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context,index) {
          final String item = _list[index].name;
          return Dismissible(
            key: Key(item),
            onDismissed: (DismissDirection dir) {
              setState(() {
                _currentSubject = _list[index];
              });
              if(dir == DismissDirection.startToEnd)
              {
                //I remove the lesson
                setState(() => {
                  this._list.removeAt(index)                  
                });
                
                //remove the lesson from the status
                Status.register.subject.remove(_currentSubject);

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$item removed.'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {                        
                        setState(() => this._list.insert(index, _currentSubject));                        
                        //Status.register.subject.add(_currentSubject);
                      },
                      
                    ),
                  ),
                );
              }
              else if(dir == DismissDirection.endToStart)
              {
                //I modify the lesson
                //TODO: modify the current lesson
              }


            },
            // Show a red background as the item is swiped away
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete),
            ),
            // Background when swipping from right to left
            secondaryBackground: Container(
              color: Colors.yellow,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.construction),
            ),
            child: subjectCard(_list[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: ()=>{},
        icon: Icon(Icons.add), label: Text('Aggiungi lezione'),
        backgroundColor: AgendaBlue900,
        )
    );
  }
}

