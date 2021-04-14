library agenda;

import 'package:flutter/material.dart';

void dialog(BuildContext context, String title, String content)
{
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title : Text(title),
      content : Text(content),
    )
  );
}

void wdialog(BuildContext context, String title, Widget content)
{
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title : Text(title),
      content : content,
    )
  );
}