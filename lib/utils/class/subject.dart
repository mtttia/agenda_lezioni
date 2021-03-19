library agenda;
import 'package:agenda_lezioni/utils/class/note.dart';


class Subject
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
      throw new Exception('Note is not valid');
    }
    _note = value;
  }

  Subject(String na, String no)
  {
    name = na;
    note = no;
  }

  Subject.fromJson(Map<String, dynamic> map)
  {
    name = map['name'];
    note = map['note'];
  }

  Map<String, dynamic> toJson() {
    return{
      "name" : name,
      "note" : note
    };
  }

  @override
  bool operator ==(other) => equals(this, other);

  bool equals(Subject first, second)
  {
    if(second is Subject)
    {
      if(first.name == second.name)
        return true;
      return false;
    }
    return false;
  }


}