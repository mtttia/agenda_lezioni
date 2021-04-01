library agenda;

abstract class WeekDay
{
  static Map<int, String> days(){
    return {
      1 : 'monday',
      2 : 'tuesday',
      3 : 'wednsday',
      4 : 'thursday',
      5 : 'friday',
      6 : 'saturday',
      7 : 'sunday'
    };
  }

  static Map<int, String> daysITA()
  {
    return {
      1 : 'Lunedì',
      2 : 'Martedì',
      3 : 'Mercoledì',
      4 : 'Giovedì',
      5 : 'Venerdì',
      6 : 'Sabato',
      7 : 'Domenica'
    };
  }

  static Map<String, int> numDaysITA()
  {
    return{
      'Lunedì' : 1,
      'Martedì' : 2,
      'Mercoledì' : 3,
      'Giovedì' : 4,
      'Venerdì' : 5,
      'Sabato' : 6,
      'Domenica' : 7,
    };
  }

  static int changeDay(int day, bool next)
  {
    if(next)
    {
      day++;
      if(day > 7)
        day = 1;
    }
    else 
    {
      day--;
      if(day < 1)
        day = 7;
    }
    return day;
  }
}