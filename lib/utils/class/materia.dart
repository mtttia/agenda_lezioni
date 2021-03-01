library agenda;
import 'package:agenda_lezioni/utils/class/note.dart';
import 'IMappable.dart';

class Subject implements IMappable
{
  String _name;
  String _note;

  String get name
  {
    return _name;
  }
  set name(String value)
  {
    if(value.isEmpty)
    {
      throw new Exception('Name is not valid');
    }
    _name = value;
  }

  String get note
  {
    return _note;
  }
  set note(String value)
  {
    if(value.isEmpty)
    {
      throw new Exception('Name is not valid');
    }
    _note = value;
  }

  Subject(String na, String no)
  {
    name = na;
    note = no;
  }

  Subject.FromMap(Map<String, dynamic> map)
  {
    name = map['name'];
    note = map['note'];
  }

  @override
  Map<String, dynamic> toMap() {
    return{
      "name" : name,
      "note" : note
    };
  }


}