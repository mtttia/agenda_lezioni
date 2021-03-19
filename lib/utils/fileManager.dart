library agenda;

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


abstract class FileManager
{
  static Future<String> get _localPath async{
    final Directory directory = await getApplicationDocumentsDirectory(); //directory position in documents folder
    print(directory.path);
    return directory.path;
  }

  static Future<File> get _localFile async{
    final path = await _localPath; //file register.json in documents
    return File(join(path, "register.json"));
  }


  static Future<File> getFile() async{
    return _localFile;
  }

  static Future<bool> save(String data)async{
    File file = await _localFile;
    file.writeAsString(data);//per append : (data, mode: FileMod.APPEND)
    return true; //per problemi nel salvataggio
  }

  static Future<String> load() async{
    File file = await _localFile;
    return file.readAsString();
  }

}