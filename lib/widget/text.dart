library agenda;

import 'package:flutter/material.dart';
import '../utils/colors.dart';

class FontText extends StatelessWidget
{
  FontText(this.text, {this.fontFamily : 'OpenSans', this.textAlign = TextAlign.left, this.color, this.fontSize});
  String text;
  String fontFamily;
  TextAlign textAlign;
  Color color;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: this.fontFamily,
        color: this.color,
        fontSize: fontSize,
      ),
      textAlign: this.textAlign,
    );
  }  
}

class Header extends StatelessWidget
{
  Header(this.text);
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25),
        Container(          
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),              
              color: accentColor(context),
              border: Border.all(
                color: BackgroundColor,
                width: 1.5,
              ),
            ),
          child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),         
          
          child: Container(
            
            
            child: Text(
              this.text,
              style: TextStyle(
                color: BackgroundColor,
                fontFamily: 'Comfortaa',
                fontSize: 14.0,
              ),
            ),
          ),
        )
        )
        
      ],
    );
  }  
}

class Subtitle extends StatelessWidget
{
  Subtitle(this.text);
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Text(text, style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : AgendaBlue900,
          fontFamily: 'OpenSans',
          fontSize: 20.0,
        ), textAlign: TextAlign.center,),
      ],
    );
  }  
}

class GreyText extends StatelessWidget{

  GreyText(this.text);
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[600],
        fontFamily: 'OpenSans',
      ),
    );
  }

}

class IconText extends StatelessWidget
{
  IconText(this.icon, this.text, {this.fontFamily=""});
  Icon icon;
  String text;
  String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child : Column(
            children: [
              icon,
              SizedBox(height : 10),
              Center(child : Text('Non ci sono lezioni oggi', textAlign: TextAlign.center, style: TextStyle(
        fontFamily: this.fontFamily
      )),)
            ],
          ),      
        ),
      ],
  );
  }
  
}

class AppBarText extends StatelessWidget
{
  AppBarText(this.text);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontFamily: 'SyneMono',
      ),
      textAlign: TextAlign.center,
    );
  }
  
}