library agenda;

import 'package:flutter/material.dart';
import '../utils/class/subject.dart';
import '../widget/text.dart';
import '../utils/colors.dart';
import '../utils/status.dart';

class AddSubjectRoute extends MaterialPageRoute<void>
{
  AddSubjectRoute(Function() callback, {bool modify = false, Subject oldSubject}) : super(builder: (BuildContext context)
  {
    return AddSubject(callback, modify:modify, oldSubject: oldSubject,);
  });
}

class AddSubject extends StatelessWidget
{
  AddSubject(this.callback, {this.modify = false, this.oldSubject});
  Function() callback;
  bool modify;
  Subject oldSubject;
  @override
  Widget build(BuildContext context) {
    if(modify)
    {
      _nameController.text = oldSubject.name;
      _noteController.text = oldSubject.note;
    }
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Aggiungi materia'),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: ()=>Navigator.of(context).pop(),
        )
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left:15.0, top:30.0, right:15.0),
            child: Column(
              children: [
                FontText('Per craere una lezione è necessario specificare il nome e un\'eventuale nota della lezione'),
                SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'nome materia',
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'note della lezioni',
                  ),
                ),
              ],
            )
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          addSubject_click(context, callback, modify: modify, oldSubject: oldSubject)
        },
        icon: Icon(Icons.add), label: Text('Aggiungi materia'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : AgendaBlue900,
      )
    );
  }
  
}


final _nameController = TextEditingController();
final _noteController = TextEditingController();

void addSubject_click(BuildContext context, Function() callback, {bool modify = false, Subject oldSubject})
{
  Subject s = new Subject(_nameController.text, note:_noteController.text);  
  _nameController.text = "";
  _noteController.text = "";
  if(modify)
    Status.register.modifySubject(oldSubject, s);
  else
    Status.register.addSubject(s);
  callback();
  Navigator.of(context).pop();  
  Status.save();
}
