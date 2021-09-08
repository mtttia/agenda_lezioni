library agenda;

import 'package:agenda_lezioni/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/status.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/text.dart';
import '../widget/dialog.dart';
import '../widget/buttonStyle.dart';
import '../utils/class/note.dart';

class NewYearRouter extends MaterialPageRoute<void>
{
  NewYearRouter() : super(builder: (BuildContext context)
  {
    return NewYear();
  });
}

class NewYear extends StatefulWidget{
  NewYear({Key key}) : super(key:key);

  @override
  _NewYearState createState() => _NewYearState();
}

class _NewYearState extends State<NewYear>{
  bool manteinLesson = false;
  bool manteinSubject = true;
  bool manteinNote = true;
  bool manteinFixedNote = true;
  bool manteinDayNote = false;
  bool manteinVolatilNote = true;
  bool manteinVolatilDayNote = true;
  bool manteinEvent = true;

  void startNewRoutine(){
    if(!manteinLesson){
      print("not manteinLesson");
      Status.register.monday = [];
      Status.register.tuesday = [];
      Status.register.wednesday = [];
      Status.register.thursday = [];
      Status.register.friday = [];
      Status.register.saturday = [];
      Status.register.sunday = [];
    }
    if(!manteinSubject){
      Status.register.monday = [];
      Status.register.tuesday = [];
      Status.register.wednesday = [];
      Status.register.thursday = [];
      Status.register.friday = [];
      Status.register.saturday = [];
      Status.register.sunday = [];
      Status.register.subject = [];
    }
    if(!manteinNote){
      Status.register.note = [];
    }
    else{
      //check other note option
      Status.register.note.forEach((element) {
        if(element is FixedNote && !manteinFixedNote){
          Status.register.note.remove(element);
        }
        if(element is DayNote && !manteinDayNote){
          Status.register.note.remove(element);
        }
        if(element is VolatileNote && !manteinVolatilNote){
          Status.register.note.remove(element);
        }
        if(element is VolatilDayNote && !manteinVolatilDayNote){
          Status.register.note.remove(element);
        }
        if(element is Event && !manteinEvent){
          Status.register.note.remove(element);
        }
      });
    }

    Status.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarText('Nuovo anno'),
          leading: IconButton(
            icon: const Icon(Icons.west),
            onPressed: ()=>Navigator.of(context).pop(),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          startNewRoutine(),Navigator.of(context).pop()
          //addSubject_click(context, callback, modify: modify, oldSubject: oldSubject)
        },
        icon: Icon(Icons.restore), label: Text('Inizia nuova routine'),
        backgroundColor: accentColor(context),
      ),
      body: ListView(
        children: [
          Header("Cambia la tua routine"),
          SizedBox(height: 25,),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: GreyText("Inizia una nuova routine o un nuovo anno scolastico con Less on \nLe opzioni preselezionate sono quelle consigliate"),
          ),
          SizedBox(height: 10,),
          CheckboxListTile(
            title: Text('Mantieni le lezioni'),
            value: manteinLesson,
            onChanged: (bool value){
              setState(() {
                manteinLesson = value;
              });
            },
            secondary: const Icon(Icons.calendar_view_day),
          ),
          CheckboxListTile(
            title: Text('Mantieni le materie'),
            value: manteinSubject,
            onChanged: (bool value){
              setState(() {
                manteinSubject = value;
              });
            },
            secondary: const Icon(Icons.school),
          ),
          CheckboxListTile(
            title: Text('Mantieni le note'),
            value: manteinNote,
            onChanged: (bool value){
              setState(() {
                manteinNote = value;
              });
            },
            secondary: const Icon(Icons.event),
          ),
          Container(
            child: !manteinNote ? null : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                GreyText("impostazioni relative ai tipi di nota presi singolarmente"),
                CheckboxListTile(
                  title: Text('Mantieni le note fisse'),
                  value: manteinFixedNote,
                  onChanged: (bool value){
                    setState(() {
                      manteinFixedNote = value;
                    });
                  },
                  secondary: const Icon(Icons.mode_edit),
                ),
                CheckboxListTile(
                  title: Text('Mantieni le note riferite a un giorno della settimana'),
                  value: manteinDayNote,
                  onChanged: (bool value){
                    setState(() {
                      manteinDayNote = value;
                    });
                  },
                  secondary: const Icon(Icons.event_note),
                ),
                CheckboxListTile(
                  title: Text('Mantieni le note volatili'),
                  value: manteinVolatilNote,
                  onChanged: (bool value){
                    setState(() {
                      manteinVolatilNote = value;
                    });
                  },
                  secondary: const Icon(Icons.flight),
                ),
                CheckboxListTile(
                  title: Text('Mantieni le note volatili e riferite a un giorno'),
                  value: manteinVolatilDayNote,
                  onChanged: (bool value){
                    setState(() {
                      manteinVolatilDayNote = value;
                    });
                  },
                  secondary: const Icon(Icons.data_usage),
                ),
                CheckboxListTile(
                  title: Text('Mantieni gli eventi'),
                  value: manteinEvent,
                  onChanged: (bool value){
                    setState(() {
                      manteinEvent = value;
                    });
                  },
                  secondary: const Icon(Icons.event),
                ),
                SizedBox(height: 70,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

