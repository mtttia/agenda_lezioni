library agenda;
import 'package:agenda_lezioni/utils/colors.dart';
import 'package:flutter/material.dart';
import 'pages/today.dart';
import 'pages/week.dart';
import 'pages/all-subject.dart';
import 'pages/note.dart';
import 'widget/text.dart';
import 'pages/intro.dart';
import 'utils/status.dart';
import 'pages/setting/setting.dart';
import 'pages/information.dart';
import 'pages/newYear.dart';

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
    final drawerItems = Container(
      color: BackgroundColor,
      child: ListView(
      children: <Widget>[
        DrawerItem(
          Icon(Icons.home, color: PrimaryColor,),
          'Home',
          ()=>{setState(() {
            _currentTabIndex = 0;
          })}
        ),
        DrawerItem(
          Icon(Icons.calendar_view_day, color: PrimaryColor,),
          'Settimana',
          ()=>{setState(() {
              _currentTabIndex = 1;
            })}
        ),
        DrawerItem(
          Icon(Icons.school, color: PrimaryColor,),
          'Lezioni',
          ()=>{setState(() {
              _currentTabIndex = 2;
            })}
        ),
        DrawerItem(
          Icon(Icons.event, color: PrimaryColor,),
          'Note',
          ()=>{setState(() {
              _currentTabIndex = 3;
            })}
        ),
        DrawerItem(
          Icon(Icons.settings, color: PrimaryColor,),
          'Impostazioni',
          () => {Navigator.of(context).push(SettingRoute())},
          pop: false,
        ),
        DrawerItem(
          Icon(Icons.info, color: PrimaryColor,),
          'Informazioni',
          () => {Navigator.of(context).push(InformationRoute())},
          pop: false,
        ),
        DrawerItem(
          Icon(Icons.backpack, color: PrimaryColor,),
          'Nuovo anno',
              () => {Navigator.of(context).push(NewYearRouter())},
          pop: false,
        ),
      ],
    ),
    );
    final _kTabPages = <Widget>[
      Today(),
      Week(),
      AllSubject(),
      Notes(),
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
    tryTutorial(context);
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

Future<void> tryTutorial(BuildContext context)
{
  Future.delayed(Duration(seconds: 2),
  ()=> openTutorial(context),
  );
  
}

void openTutorial(BuildContext context)
{
  if(Status.firstOpen){
    Navigator.of(context).push(IntroRoute());
    Status.firstOpen = false;
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


class DrawerItem extends StatelessWidget
{
  DrawerItem(this.icon, this.text, this.fun, {this.selected = false, this.pop = true}):super();
  Icon icon;
  String text;
  Function() fun;
  bool selected;
  bool pop;

  @override
  Widget build(BuildContext context) {
  

    return Column(
      children: [
        ListTile(
          focusColor: SecondaryColor,
          hoverColor: SecondaryColor,
          selected: selected,
          enabled: true,
          title: Row(children: [
            icon,
            SizedBox(width: 10),
            FontText(this.text, color: PrimaryColor, fontSize: 16,),
          ],),
          onTap: () {
            this.fun();
            if(pop)
            {
              Navigator.pop(context);
            }
          },
        ),
        //Divider(),
      ],
    );

  }
  
}

class Divider extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: SizedBox(
        height: 1,
        child: Container(color: PrimaryColor,),
      ),
    );
  }
  
}