library agenda;

import 'dart:convert';

import 'package:agenda_lezioni/utils/class/register.dart';
import 'package:agenda_lezioni/utils/fileManager.dart';

class Status
{
  static Register register;
  static bool firstOpen;
  
  static void initializeAll(bool first)
  {
    firstOpen = first;
    DateTime today = new DateTime.now();
    register = new Register(today.weekday);
    //TODO : create the file register.json
    //FileManager.save(jsonEncode(register.toJson()));
  }

  static initializeFromJson(String json)
  {
    try
    {
      firstOpen = false;
      Map<String, dynamic> map = jsonDecode(json);
      DateTime today = new DateTime.now();
      register = new Register.fromJson(map, today.weekday);
    }catch(ex)
    {
      throw ex;
    }
  }

}