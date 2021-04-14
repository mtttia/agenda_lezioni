library agenda;

import 'dart:convert';
import 'class/lesson.dart';
import 'package:agenda_lezioni/utils/class/register.dart';
import 'package:agenda_lezioni/utils/fileManager.dart';

class Status
{
  static Register register;
  static bool firstOpen; 
  
  static void initalize()
  {
    firstOpen = true;
    DateTime today = new DateTime.now();
    register = new Register(today.weekday);
    //TODO : delete the comment
    //FileManager.save(jsonEncode(register.toJson()));
    Status.save();
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

  static void save()
  {
    FileManager.save(jsonEncode(register.toJson()));
  }

  

}