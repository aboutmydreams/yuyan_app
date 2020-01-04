import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile(String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  return File('$path/$fileName.json');
}

Future<File> writeJson(String fileName, Map jsonMap) async {
  final file = await getLocalFile(fileName);
  return file.writeAsString(jsonEncode(jsonMap));
}
