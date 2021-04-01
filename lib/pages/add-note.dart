library agenda;

import 'package:agenda_lezioni/utils/class/weekDay.dart';
import 'package:flutter/material.dart';
import '../utils/class/subject.dart';
import '../utils/class/note.dart';
import '../widget/text.dart';
import '../utils/colors.dart';
import '../utils/status.dart';
import '../widget/dialog.dart';

class AddNoteRoute extends MaterialPageRoute<void>
{
  AddNoteRoute(Function() callback, {bool modify = false, Note oldNote}) : super(builder: (BuildContext context)
  {
    return AddNote(callback, modify : modify, oldNote: oldNote,);
  });
}

class AddNote extends StatefulWidget
{
  AddNote(this.callback, {this.modify = false, this.oldNote});
  Function() callback;
  bool modify;
  Note oldNote;

  @override
  _AddNote createState() => _AddNote(callback, modify: modify, oldNote: oldNote);
}

class _AddNote extends State<AddNote>
{//TODO:implement the change of the interface and the interfaces
  //the interface that will be show when I change the type of note
  _AddNote(this.callback, {this.modify = false, this.oldNote});
  Function() callback;
  bool modify;
  Note oldNote;

  Widget _interface = getWidgetForTypeOfNote('generica');
  Subject _subjectSelected;
  String _typeOfNote;


  //list of type of note
  static const noteType= <String>[
    'generica',
    'giorno',
    'volatile',
    'volatile e giorno',
    'evento',
  ];

  final List<DropdownMenuItem<String>> _dropdownNoteType = noteType.map(
    (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  ).toList();


  @override
  Widget build(BuildContext context) {
    if(modify)
    {
      _nameController.text = oldNote.name;
      _noteController.text = oldNote.text;
      _subjectSelected = oldNote.subject;
      _typeOfNote = noteTypeITA(oldNote);
      _interface = getWidgetForTypeOfNote(_typeOfNote);
    }
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Aggiungi nota'),
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
                FontText('Per craere una nota è necessario specificare il tipo di nota, il nome, il testo, ed ulteriori eventuali chiarimenti in base al tipo di nota'),
                SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'nome nota',
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'testo della nota',
                  ),
                ),
                SizedBox(height: 30),
                ListTile(
                  title: FontText('materia di riferimento'),
                  trailing: DropdownButton(
                    items: getDropdownMenuItems(),
                    value: _subjectSelected,
                    onChanged: (Subject value)=>{
                      setState(()=>{
                        _subjectSelected = value
                      })
                    }
                  ),
                ),
                SizedBox(height: 30),
                ListTile(
                  title: FontText('tipo di nota'),
                  trailing: DropdownButton(
                    items: _dropdownNoteType,
                    value: _typeOfNote,
                    onChanged: (String value)=>{
                      setState(()=>{
                        _typeOfNote = value,
                        _interface = getWidgetForTypeOfNote(value)
                      })
                    }
                  ),
                ),
                _interface,
              ],
            )
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          addNote_click(context, callback, _subjectSelected, _typeOfNote, modify: modify, oldNote: oldNote)
        },
        icon: Icon(Icons.add), label: Text('Aggiungi nota'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : AgendaBlue900,
      )
    );
  }
  
}


final _nameController = TextEditingController();
final _noteController = TextEditingController();

//depends on note type
int daySelected = 0;
DateTime volatile = null;
DateTime event = null;

void addNote_click(BuildContext context, Function() callback, Subject s, String noteType, {bool modify = false, Note oldNote})
{
  try
  {
    String name = _nameController.text;
    String note = _noteController.text;
    _nameController.text = "";
    _noteController.text = "";

    //see what type of note is the note to add
    Note toAdd;
    print('note type : '+noteType);
    switch(noteType)
    {
      case 'generica': 
        //add a fixed note
        toAdd = new FixedNote(name, note, s);
        break;
      case 'giorno': 
        //add a fixed note
        if(daySelected <= 0 && daySelected > 7)
        {
          //if daySelected isn't correct, throw an exception
          throw new Exception('nessun giorno selezionato');
        }
        toAdd = new DayNote(name, note, s, daySelected);
        break;
      case 'volatile': 
        //add a volatile note
        if(volatile == null)
        {
          //volatile isn't initailized
          throw new Exception('data di scadenza non inizializzata');
        }
        toAdd = new VolatileNote(name, note, s, volatile);
        break;
      case 'volatile e giorno': 
        //add a VolatileDay note
        if(daySelected <= 0 && daySelected > 7)
        {
          //if daySelected isn't correct, throw an exception
          throw new Exception('nessun giorno selezionato');
        }
        if(volatile == null)
        {
          //volatile isn't initailized
          throw new Exception('data di scadenza non inizializzata');
        }
        toAdd = new VolatilDayNote(name, note, s, volatile, daySelected);
        break;
      case 'evento': 
        //add a event
        if(event == null)
        {
          //event isn't initailized
          throw new Exception('date dell\'evento non inizializzata');
        }
        toAdd = new Event(name, note, s, event);
        break;
    }

    if(toAdd == null)
    {
      throw new Exception('internal error');
    }
    if(modify)
      Status.register.modifyNote(oldNote, toAdd);
    else
      Status.register.addNote(toAdd);    
    Navigator.of(context).pop();
    callback();
    Status.save();
  }catch(ex)
  {
    dialog(context, 'Attenzione', ex.toString());
  }
}



List<String> getMenuItems()
{
  List<String> list = new List<String>();
  for(Subject s in Status.register.subject)
  {
    list.add(s.name);
  }
  return list;
}

List<DropdownMenuItem<Subject>> getDropdownMenuItems()
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

Widget getWidgetForTypeOfNote(String type)
{
  switch(type)
  {
    case 'generica' : return forGeneric();
    case 'giorno' : return forDay();
    case 'volatile' : return forVolatile();
    case 'volatile e giorno' : return forVolatilDay();
    case 'evento' : return forEvent();
  }
  throw new Exception('internal error');
}

Widget forGeneric()
{
  return Container();
}

Widget forDay()
{
  return ForDay();
}

class ForDay extends StatefulWidget
{
  @override
  _ForDay createState() => _ForDay();

}

class _ForDay extends State<ForDay>
{
  static const days = <String>[
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  final List<DropdownMenuItem<String>> _dropDownDaysItems = days
    .map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    )
    .toList();

  String _selectedDay;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FontText('seleziona il giorno:'),
      trailing: DropdownButton(
        value: _selectedDay,
        hint: const Text('Choose'),
        onChanged: (String value) {
          daySelected = WeekDay.numDaysITA()[value];
          setState(() {
            _selectedDay = value;
          });
        },
        items: _dropDownDaysItems,
      ),
    );
  }
  
}

Widget forVolatile()
{
  return ForVolatile();
}

class ForVolatile extends StatefulWidget
{

  _ForVolatile createState() => _ForVolatile();
}

class _ForVolatile extends State<ForVolatile>
{
  DateTime _dateSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextButton.icon(
        icon: Icon(Icons.date_range),
        label: FontText('data di scadenza'),
        onPressed: ()=>{
          getDateTime(context, 'seleziona la data dopo la quale la nota verrà cancellata').then((value) => {
            setState(()=>{
              volatile = value,
              _dateSelected = value
            })
          })
        },
      ),
      trailing: FontText(_dateSelected == null ? '' : _dateSelected.day.toString() + '/'+ _dateSelected.month.toString() + '/' + _dateSelected.year.toString()),
    );
  }
}

Future<DateTime> getDateTime(BuildContext context, String info)
{
  final DateTime now = DateTime.now();
  final DateTime max = new DateTime(2040);
  return showDatePicker(
    context: context, 
    initialDate: now, 
    firstDate: now, 
    lastDate: max,
    helpText: info,    
  );
}

Widget forVolatilDay()
{
  return Column(children: [
    forDay(),
    forVolatile()
  ]);
}

Widget forEvent()
{
  return ForEvent();
}

class ForEvent extends StatefulWidget
{

  _ForEvent createState() => _ForEvent();
}

class _ForEvent extends State<ForEvent>
{
  DateTime _day;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextButton.icon(
        icon: Icon(Icons.date_range),
        label: FontText('data dell\'evento'),
        onPressed: ()=>{
          getDateTime(context, 'seleziona la data dell\'evento').then((value) => {
            setState(()=>{
              event = value,
              _day = value
            })
          })
        },
      ),
      trailing: FontText(_day == null ? '' : _day.day.toString() + '/'+ _day.month.toString() + '/' + _day.year.toString()),
    );
  }
  
}