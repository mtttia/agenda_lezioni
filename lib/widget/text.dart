library agenda;

import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';

class FontText extends StatelessWidget
{
  FontText(this.text, {this.fontFamily : 'OpenSans', this.textAlign = TextAlign.left});
  String text;
  String fontFamily;
  TextAlign textAlign;
  

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: this.fontFamily
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
        Text(
          this.text,
          style: TextStyle(
            color: AgendaBlue900,
            fontFamily: 'Comfortaa',
            fontSize: 30.0,
          ),
          textAlign: TextAlign.center,
        )
      ],
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