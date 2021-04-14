//for now it is not used, it may be util in future
library agenda;

class Duration
{
  int _hour;
  set hour(int value){
    if(value < 0 || value >= 24)
    {
      throw new Exception('hour not valid');
    }
    _hour = value;
  }
  int get hour{
    return _hour;
  }
  int _minute;
  set minute(int value){
    if(value < 0 || value >= 60){
      throw new Exception('minute not valid');
    }
    _minute = value;
  }
  int get minute{
    return _minute;
  }

  Duration(int h, int m)
  {
    try
    {
      hour = h;
      minute = m;
    }catch(ex)
    {
      throw ex;
    }
  }

  
}