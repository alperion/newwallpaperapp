import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';
import 'dart:async';

class FileProcess {
  static Future<String> get getFilePath async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/carbon.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    return file.writeAsString(data);
  }

  static Future<List<String>> readFromFile() async {
    List<String> k = [""];

    try {
      final file = await getFile;
      List<String> fileContents = await file.readAsLines();
      return fileContents;
    } catch (e) {
      return k;
    }
  }
}
