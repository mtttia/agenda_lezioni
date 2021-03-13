library agenda;

import 'package:flutter/material.dart';

class MapTimeOfDay
{
  static Map<String, dynamic> map(TimeOfDay time)
  {
    return{
      "hour" : time.hour,
      "minute" : time.minute
    };
  }
  static TimeOfDay decode(Map<String, dynamic> m)
  {
    try
    {
      TimeOfDay time = new TimeOfDay(hour: m['hour'], minute: m['minute']);
      return time;
    }catch(ex)
    {
      throw ex;
    }
  }
}