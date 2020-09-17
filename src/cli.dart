import 'dart:io';
import 'lib/wiki_load.dart';
import 'lib/pharmacon.dart';

void main(List<String> arguments) async {
  String language = arguments[0].toLowerCase();
  String name = arguments[1].toLowerCase();
  // print("::" + language);
  String pharmaJSON = await loadJSON(language: language, name: name);
  print(pharmaJSON);
}
