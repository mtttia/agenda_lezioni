library agenda;

import 'package:agenda_lezioni/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/text.dart';
import '../widget/dialog.dart';
import '../widget/buttonStyle.dart';

class InformationRoute extends MaterialPageRoute<void>
{
  InformationRoute() : super(builder: (BuildContext context)
  {
    return Information();
  });
}

class Information extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Informazioni'),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: ()=>Navigator.of(context).pop(),
        )
      ),
      body: ListView(
        children: [
          InfoSection(
            title: 'Assistenza e tutorial',
            content: 'Less-on dispone di un semplice tutorial accessibile a chiunque, clicca qui per visualizzarlo',
            iconButton: Icon(Icons.lightbulb),
            textButton: 'Vai al tutorial',
            callback: ()=>{
              //go to https://less-on.netlify.app/tutorial.html
              openLink("https://less-on.netlify.app/tutorial.html")
            },
          ),
          Divider(),
          InfoSection(
            title: 'Info sull\'app',
            content: 'Sul sito web ci sono tutte le informazioni relative all’applicazione. \nCollegati al sito cliccando il bottone sottostante. \nBuona navigazione',
            iconButton: Icon(Icons.language),
            textButton: 'Vai al sito web',
            callback: ()=>{
              //go to https://less-on.netlify.app/
              openLink("https://less-on.netlify.app/")
            },
          ),
          Divider(),
          ListTile(
            title: FontText('Licenza'),
            trailing: TextButton.icon(
              style: textButtonStyle(),
              onPressed: ()=>{
                wdialog(context, 'GNU GENERAL PUBLIC LICENSE', ElevatedButton.icon(
                icon: Icon(Icons.language),
                label: Text('Leggi la licenza'),
                style: elevatedButtonStyle(),
                onPressed: ()=>{
                  //TODO : go to https://github.com/mtttia/agenda_lezioni/blob/master/LICENSE
                  //TODO : remember to change domain
                  openLink("https://github.com/mtttia/agenda_lezioni/blob/master/LICENSE")
                }
                ),)
              },
              icon: Icon(Icons.gavel), 
              label: Text('GPL-3.0'),
            ),
          )

        ],
      ),
    );
  }

}

class Divider extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
      child: SizedBox(
        height: 1,
        child: Container(color: PrimaryColor),
      ),
    );
  }
  
}

openLink(String url) async{
  if (await canLaunch(url))
    await launch(url);
  else 
    // can't launch url
    throw "Could not launch $url";
}


class InfoSection extends StatelessWidget
{
  InfoSection({this.title, this.content, this.iconButton, this.textButton, this.callback})
  {
    assert(this.title != null, "error");
    assert(this.content != null, "error");
    assert(this.iconButton != null, "error");
    assert(this.textButton != null, "error");
    assert(this.callback != null, "error");
  }
  
  String title;
  String content;
  Icon iconButton;
  String textButton;
  Function() callback;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Header(title),
      SizedBox(height: 25,),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: GreyText(content),
      ),
      SizedBox(height: 10,),
      Center(
        child: ElevatedButton.icon(
          icon: iconButton,
          label: Text(textButton),
          style: outlineElevatedButtonStyle(),
          onPressed: callback,
        ),
      )
    ],);
  }

}

