library agenda;
import 'package:flutter/material.dart';
import 'pages/today.dart';
import 'pages/week.dart';
import 'pages/all-subject.dart';
import 'pages/note.dart';
import 'widget/text.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home
    extends State<Home> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final drawerItems = ListView(
      children: <Widget>[
        ListTile(
          title: Row(children: [
            Icon(Icons.home),
            SizedBox(width: 10),
            Text('Home')
          ],),
          onTap: () {
            setState(() {
              _currentTabIndex = 0;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(children: [
            Icon(Icons.calendar_view_day),
            SizedBox(width: 10),
            Text('Settimana')
          ],),
          onTap: () {
            setState(() {
              _currentTabIndex = 1;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(children: [
            Icon(Icons.school),
            SizedBox(width: 10),
            Text('Lezioni')
          ],),
          onTap: () {
            setState(() {
              _currentTabIndex = 2;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(children: [
            Icon(Icons.event),
            SizedBox(width: 10),
            Text('Note')
          ],),
          onTap: () {
            setState(() {
              _currentTabIndex = 3;
            });
            Navigator.pop(context);
          },
        ),
      ],
    );
    final _kTabPages = <Widget>[
      Today(),
      Week(),
      AllSubject(),
      Notes()
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.calendar_view_day), label: 'Settimana'),
      const BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Lezioni'),
      const BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Note'),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: AppBarText('Agenda Lezioni'),
        ),
        body: _kTabPages[_currentTabIndex],
        drawer: Drawer(
          child: drawerItems,
        ),
        bottomNavigationBar: bottomNavBar,
    );
  }
}



// <void> means this route returns nothing.
class _NewPage extends MaterialPageRoute<void> {
  _NewPage(int id)
      : super(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $id'),
        elevation: 1.0,
      ),
      body: Center(
        child: Text('Page $id'),
      ),
    );
  });
}