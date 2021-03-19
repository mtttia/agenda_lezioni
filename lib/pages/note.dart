library agenda;

import 'package:flutter/material.dart';
import '../utils/class/note.dart';
import '../utils/status.dart';
import '../widget/card.dart';
import '../widget/text.dart';
import '../utils/colors.dart';

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



class TabsNote extends StatelessWidget {
  const TabsNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      ListFixedNote(),
      ListDayNote(),
      ListVolatileNote(),
      ListVolatilDayNote(),
      ListEvent(),
    ];
    final _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.mode_edit), text: 'fisse'),
      const Tab(icon: Icon(Icons.event_note), text: 'giorno'),
      const Tab(icon: Icon(Icons.flight), text: 'volatili'),
      const Tab(icon: Icon(Icons.data_usage), text: 'volatili e giorno'),
      const Tab(icon: Icon(Icons.event), text: 'eventi'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Note')),
          backgroundColor: AgendaBlue900,
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
      floatingActionButton: FloatingActionButton.extended(onPressed: ()=>{},
        icon: Icon(Icons.note_add), label: Text('Aggiungi nota'),
        backgroundColor: AgendaBlue900,
        )
      ),
    );
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
  FixedNote _current = null;

  @override
  Widget build(BuildContext context) {
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
          child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context,index) {
        final String item = _list[index].name;
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              _current = _list[index];
            });
            if(dir == DismissDirection.startToEnd)
            {
              //I remove the lesson
              setState(() => {
                this._list.removeAt(index)                  
              });
              
              //remove the lesson from the status
              Status.register.subject.remove(_current as Note);

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item removed.'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {                        
                      setState(() => this._list.insert(index, _current));                        
                      //Status.register.subject.add(_currentSubject);
                    },
                    
                  ),
                ),
              );
            }
            else if(dir == DismissDirection.endToStart)
            {
              //I modify the note
              //TODO: modify the current note
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
          child: fixedNoteCard(_list[index]),
        );
      },
    )
        )
      ],),
        )
      ],)
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
          child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context,index) {
        final String item = _list[index].name;
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              _current = _list[index];
            });
            if(dir == DismissDirection.startToEnd)
            {
              //I remove the lesson
              setState(() => {
                this._list.removeAt(index)                  
              });
              
              //remove the lesson from the status
              Status.register.subject.remove(_current as Note);

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item removed.'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {                        
                      setState(() => this._list.insert(index, _current));                        
                      //Status.register.subject.add(_currentSubject);
                    },
                    
                  ),
                ),
              );
            }
            else if(dir == DismissDirection.endToStart)
            {
              //I modify the note
              //TODO: modify the current note
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
          child: dayNoteCard(_list[index]),
        );
      },
    )
        )
      ],),
        )
      ],)
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
          child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context,index) {
        final String item = _list[index].name;
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              _current = _list[index];
            });
            if(dir == DismissDirection.startToEnd)
            {
              //I remove the lesson
              setState(() => {
                this._list.removeAt(index)                  
              });
              
              //remove the lesson from the status
              Status.register.subject.remove(_current as Note);

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item removed.'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {                        
                      setState(() => this._list.insert(index, _current));                        
                      //Status.register.subject.add(_currentSubject);
                    },
                    
                  ),
                ),
              );
            }
            else if(dir == DismissDirection.endToStart)
            {
              //I modify the note
              //TODO: modify the current note
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
          child: volatileNoteCard(_list[index]),
        );
      },
    )
        )
      ],),
        )
      ],)
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
          child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context,index) {
        final String item = _list[index].name;
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              _current = _list[index];
            });
            if(dir == DismissDirection.startToEnd)
            {
              //I remove the lesson
              setState(() => {
                this._list.removeAt(index)                  
              });
              
              //remove the lesson from the status
              Status.register.subject.remove(_current as Note);

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item removed.'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {                        
                      setState(() => this._list.insert(index, _current));                        
                      //Status.register.subject.add(_currentSubject);
                    },
                    
                  ),
                ),
              );
            }
            else if(dir == DismissDirection.endToStart)
            {
              //I modify the note
              //TODO: modify the current note
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
          child: volatilDayNoteCard(_list[index]),
        );
      },
    )
        )
      ],),
        )
      ],)
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
          child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context,index) {
        final String item = _list[index].name;
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              _current = _list[index];
            });
            if(dir == DismissDirection.startToEnd)
            {
              //I remove the lesson
              setState(() => {
                this._list.removeAt(index)                  
              });
              
              //remove the lesson from the status
              Status.register.subject.remove(_current as Note);

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item removed.'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {                        
                      setState(() => this._list.insert(index, _current));                        
                      //Status.register.subject.add(_currentSubject);
                    },
                    
                  ),
                ),
              );
            }
            else if(dir == DismissDirection.endToStart)
            {
              //I modify the note
              //TODO: modify the current note
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
          child: eventCard(_list[index]),
        );
      },
    )
        )
      ],),
        )
      ],)
    );
  }
}