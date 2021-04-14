library agenda;

import 'package:flutter/material.dart';
import '../../widget/text.dart';
import '../../utils/status.dart';
import '../../widget/buttonStyle.dart';

class SettingRoute extends MaterialPageRoute<void>
{
  SettingRoute() : super(builder: (BuildContext context)
  {
    return Setting();
  });
}

class Setting extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Impostazioni'),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: ()=>Navigator.of(context).pop(),
        )
      ),
      body: SettingPage(),
    );
  }
}

class SettingPage extends StatefulWidget
{


  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage>{
  
  TimeOfDay _defaultDuration;
  TimeOfDay _startTime;

  @override
  void initState() {
    super.initState();
    _defaultDuration = Status.register.defaultDuration;
    _startTime = Status.register.startTimeDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Header('Preferenze di default'),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: GreyText('Questa sezione riguarda le preferenze di default ovvero i consigli che da l\'app delle lezioni : l\'ora di inizo e la durata'),
          ),
          ListTile(
            title: TextButton.icon(
              icon: Icon(Icons.schedule),
              label: FontText('durata default'),
              style: textButtonStyle(),
              onPressed: ()=>{
                getTimePicker(context, 'seleziona la durata di defalut', startTime: _defaultDuration).then((value) => {
                  changeDefaultDuration(value)
                })
              },
            ),
            trailing: FontText(_defaultDuration == null ? '' : _defaultDuration.hour.toString() + ' : '+ _defaultDuration.minute.toString()),
          ),
          ListTile(
            title: TextButton.icon(
              icon: Icon(Icons.schedule),
              label: FontText('ora di inizio'),
              style: textButtonStyle(),
              onPressed: ()=>{
                getTimePicker(context, 'seleziona l\'ora di inizio', startTime: _startTime).then((value) => {
                  changeStartTime(value)
                })
              },
            ),
            trailing: FontText(_startTime == null ? '' : _startTime.hour.toString() + ' : '+ _startTime.minute.toString()),
          ),

        ],
      )
    );
  }

  void changeDefaultDuration(value)
  {
    setState(()=>{
      _defaultDuration = value
    });
    Status.register.defaultDuration = value;
  }

  void changeStartTime(value)
  {
    setState(()=>{
      _startTime = value
    });
    Status.register.startTimeDefault = value;
  }

}

Future<TimeOfDay> getTimePicker(BuildContext context, String info, {TimeOfDay startTime})
{
  DateTime now = new DateTime.now();
  TimeOfDay t = startTime == null ? new TimeOfDay(hour: now.hour, minute: now.minute) : startTime;
  return showTimePicker(
    context: context, 
    initialTime: t,
    helpText: info,    
  );
}