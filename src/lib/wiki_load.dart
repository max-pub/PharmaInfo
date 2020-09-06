import 'pharmacon.dart';
import 'package:http/http.dart' as http;
import 'wiki_page.dart';
import 'dart:io';

/// load and parse a Wikipedia page
Future<Pharmacon> loadPharmacon({language, name}) async {
  final response = await http.get('https://$language.wikipedia.org/wiki/$name');

  WikiPage page = WikiPage.fromHTML(response.body);
  return Pharmacon()
    ..INN = name
    ..ATC = page.ATC
    ..CAS = page.CAS;

  // return Pharmacon(
  //     INN: name,
  //     CAS: page.CAS,
  //     ATC: page.ATC,
  //     // tradeNames: ['bla bla'],
  //     formula: page.formula);
}

Future<String> loadJSON({language, name}) async {
  File cache = File('../cache/$language.$name.json');
  if (cache.existsSync()) {
    print("load from cache");
    return cache.readAsStringSync();
  } else {
    print("load from network");
    Pharmacon pharmacon = await loadPharmacon(language: language, name: name);
    cache.writeAsStringSync(pharmacon.JSON);
    return pharmacon.JSON;
  }
}
