library agenda;

import 'package:flutter/material.dart';
import '../utils/class/note.dart';
import '../utils/status.dart';
import '../widget/card.dart';
import '../widget/text.dart';
import '../utils/colors.dart';
import 'add-note.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Notes extends StatelessWidget
{
  Notes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabsNote(),
    );
  }  
}

void setReset(Function() callback)
{
  reset = callback;
}
Function() reset;



class TabsNote extends StatefulWidget {
  const TabsNote({Key key}) : super(key: key);

  TabsNoteState createState() => TabsNoteState();


}

class TabsNoteState extends State<TabsNote>
{
  List<Widget> _kTabPages = <Widget>[
    ListFixedNote(),
    ListDayNote(),
    ListVolatileNote(),
    ListVolatilDayNote(),
    ListEvent(),
  ];
  List<Tab> _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.mode_edit), text: 'fisse'),
      const Tab(icon: Icon(Icons.event_note), text: 'giorno'),
      const Tab(icon: Icon(Icons.flight), text: 'volatili'),
      const Tab(icon: Icon(Icons.data_usage), text: 'volatili e giorno'),
      const Tab(icon: Icon(Icons.event), text: 'eventi'),
    ];


  @override
  Widget build(BuildContext context) {
    setReset(()=>{setState(()=>{_kTabPages = <Widget>[
    ListFixedNote(),
    ListDayNote(),
    ListVolatileNote(),
    ListVolatilDayNote(),
    ListEvent(),
  ]})});
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Note')),
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : AgendaBlue900,
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),        
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{
          Navigator.of(context).push(AddNoteRoute(()=>{setState((){})}))
        },
        icon: Icon(Icons.note_add), label: Text('Aggiungi nota'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : AgendaBlue900,
        )
      ),
    );
  }

  void reload()
  {
    setState(()=>{});
  }
  
}




class ListFixedNote extends StatefulWidget
{
  ListFixedNote({Key key}) : super(key:key);

  @override
  _ListFixedNoteState createState() => _ListFixedNoteState();

  
}

class _ListFixedNoteState extends State<ListFixedNote>
{
  List<FixedNote> _list = Status.register.fixedNote;
  List<Slidable> _items;
  FixedNote _current = null;

  @override
  Widget build(BuildContext context) {
    Status.save();
    print("length : " + Status.register.fixedNote.length.toString());
    return Scaffold(
      body: GridView.count(      
      crossAxisCount: 1,
      children: [
        SafeArea(
        child: Column(children: [
        Center(child: Header('Fisse')),
        SizedBox(height: 50,),
        Expanded(
          flex: 1,
          child: ListView(children: getListNote(fixedNoteCard)),
        )
      ],),
        )
      ],)
    );
  }

  void deleteNote(Note n)
  {
    Status.register.removeNote(n);
    setState(() {
      
      _list.remove(n);
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(n.name + ' rimossa'),
        action: SnackBarAction(
          label: 'UNDO', 
          onPressed: (){
            setState(() {
              _list.add(n);
              Status.save();
            });
          }
        ),
      )
    );
    Status.save();
  }

  void modifyNote(Note n)
  {
    //TODO : modify the note
    Navigator.of(context).push(AddNoteRoute(()=>{setState(()=>{})}, modify: true, oldNote: n));
    setState(() {});
  }

  List<Widget> getListNote(Function(Note n) f)
  {
    List<Widget> list = new List<Widget>();
    for(Note n in _list)
    {
      list.add(getNote(n, f(n)));
    }
    return list;
  }

  Slidable getNote(Note n, Widget item)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifyNote(n),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteNote(n),
        ),
      ],
      child: item,
    );
  }


  
}



class ListDayNote extends StatefulWidget
{
  ListDayNote({Key key}) : super(key:key);

  @override
  _ListDayNoteState createState() => _ListDayNoteState();

  
}

class _ListDayNoteState extends State<ListDayNote>
{
  List<DayNote> _list = Status.register.dayNote;
  DayNote _current = null;

  @override
  Widget build(BuildContext context) {
    Status.save();
    return Scaffold(
      body: GridView.count(      
      crossAxisCount: 1,
      children: [
        SafeArea(
        child: Column(children: [
        Center(child: Header('Giorno')),
        SizedBox(height: 50,),
        Expanded(
          flex: 1,
          child: ListView(children: getListNote(fixedNoteCard)),
        )
      ],),
        )
      ],)
    );
  }

  void deleteNote(Note n)
  {
    setState(() {
      //Status.register.removeNote(n);
      _list.remove(n);
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(n.name + ' rimossa'),
        action: SnackBarAction(
          label: 'UNDO', 
          onPressed: (){            
            setState(() {
              _list.add(n);              
            });
            Status.save();
          }
        ),
      )
    );
    Status.save();
  }

  void modifyNote(Note n)
  {
    //TODO : modify the note
    Navigator.of(context).push(AddNoteRoute(()=>{setState(()=>{})}, modify: true, oldNote: n));
    setState(() {});
  }

  List<Widget> getListNote(Function(Note n) f)
  {
    List<Widget> list = new List<Widget>();
    for(Note n in _list)
    {
      list.add(getNote(n, f(n)));
    }
    return list;
  }

  Slidable getNote(Note n, Widget item)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifyNote(n),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteNote(n),
        ),
      ],
      child: item,
    );
  }
}




class ListVolatileNote extends StatefulWidget
{
  ListVolatileNote({Key key}) : super(key:key);

  @override
  _ListVolatileNoteState createState() => _ListVolatileNoteState();

  
}

class _ListVolatileNoteState extends State<ListVolatileNote>
{
  List<VolatileNote> _list = Status.register.volatilNote;
  VolatileNote _current = null;

  @override
  Widget build(BuildContext context) {
    Status.save();
    return Scaffold(
      body: GridView.count(      
      crossAxisCount: 1,
      children: [
        SafeArea(
        child: Column(children: [
        Center(child: Header('Volatili')),
        SizedBox(height: 50,),
        Expanded(
          flex: 1,
          child: ListView(children: getListNote(fixedNoteCard)),
        )
      ],),
        )
      ],)
    );
  }

  void deleteNote(Note n)
  {
    Status.register.removeNote(n);
    setState(() {
      //Status.register.removeNote(n);
      _list.remove(n);
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(n.name + ' rimossa'),
        action: SnackBarAction(
          label: 'UNDO', 
          onPressed: (){
            setState(() {
              _list.add(n);
              
            });
            Status.save();
          }
        ),
      )
    );
    Status.save();
    
  }

  void modifyNote(Note n)
  {
    //TODO : modify the note
    Navigator.of(context).push(AddNoteRoute(()=>{setState(()=>{})}, modify: true, oldNote: n));
    setState(() {});
  }

  List<Widget> getListNote(Function(Note n) f)
  {
    List<Widget> list = new List<Widget>();
    for(Note n in _list)
    {
      list.add(getNote(n, f(n)));
    }
    return list;
  }

  Slidable getNote(Note n, Widget item)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifyNote(n),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteNote(n),
        ),
      ],
      child: item,
    );
  }
}



class ListVolatilDayNote extends StatefulWidget
{
  ListVolatilDayNote({Key key}) : super(key:key);

  @override
  _ListVolatilDayNoteState createState() => _ListVolatilDayNoteState();

  
}

class _ListVolatilDayNoteState extends State<ListVolatilDayNote>
{
  List<VolatileNote> _list = Status.register.volatilDayNote;
  VolatileNote _current = null;

  @override
  Widget build(BuildContext context) {
    Status.save();
    return Scaffold(
      body: GridView.count(      
      crossAxisCount: 1,
      children: [
        SafeArea(
        child: Column(children: [
        Center(child: Header('Volatili e giorno')),
        SizedBox(height: 50,),
        Expanded(
          flex: 1,
          child: ListView(children: getListNote(fixedNoteCard)),
        )
      ],),
        )
      ],)
    );
  }

  void deleteNote(Note n)
  {
    Status.register.removeNote(n);
    setState(() {
      //Status.register.removeNote(n);
      _list.remove(n);
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(n.name + ' rimossa'),
        action: SnackBarAction(
          label: 'UNDO', 
          onPressed: (){
            setState(() {
              _list.add(n);
              
            });
            Status.save();
          }
        ),
      )
    );
    Status.save();
  }

  void modifyNote(Note n)
  {
    //TODO : modify the note
    Navigator.of(context).push(AddNoteRoute(()=>{setState(()=>{})}, modify: true, oldNote: n));
    setState(() {});
  }

  List<Widget> getListNote(Function(Note n) f)
  {
    List<Widget> list = new List<Widget>();
    for(Note n in _list)
    {
      list.add(getNote(n, f(n)));
    }
    return list;
  }

  Slidable getNote(Note n, Widget item)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifyNote(n),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteNote(n),
        ),
      ],
      child: item,
    );
  }
}




class ListEvent extends StatefulWidget
{
  ListEvent({Key key}) : super(key:key);

  @override
  _ListEventState createState() => _ListEventState();

  
}

class _ListEventState extends State<ListEvent>
{
  List<Event> _list = Status.register.event;
  Event _current = null;

  @override
  Widget build(BuildContext context) {
    Status.save();
    return Scaffold(
      body: GridView.count(      
      crossAxisCount: 1,
      children: [
        SafeArea(
        child: Column(children: [
        Center(child: Header('Evento')),
        SizedBox(height: 50,),
        Expanded(
          flex: 1,
          child: ListView(children: getListNote(fixedNoteCard)),
        )
      ],),
        )
      ],)
    );
  }

    void deleteNote(Note n)
  {
    Status.register.removeNote(n);
    setState(() {
      //Status.register.removeNote(n);
      _list.remove(n);
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(n.name + ' rimossa'),
        action: SnackBarAction(
          label: 'UNDO', 
          onPressed: (){
            setState(() {
              _list.add(n);
              
            });
            Status.save();
          }
        ),
      )
    );
    Status.save();
    
  }

  void modifyNote(Note n)
  {
    //TODO : modify the note
    Navigator.of(context).push(AddNoteRoute(()=>{setState(()=>{})}, modify: true, oldNote: n));
    setState(() {});
  }

  List<Widget> getListNote(Function(Note n) f)
  {
    List<Widget> list = new List<Widget>();
    for(Note n in _list)
    {
      list.add(getNote(n, f(n)));
    }
    return list;
  }

  Slidable getNote(Note n, Widget item)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Modifica',
          color: AgendaYellow,
          icon: Icons.construction,
          onTap: () => modifyNote(n),
        ),
        IconSlideAction(              
          caption: 'Elimina',
          color: AgendaErrorRed,
          icon: Icons.delete,
          onTap: () => deleteNote(n),
        ),
      ],
      child: item,
    );
  }
}
