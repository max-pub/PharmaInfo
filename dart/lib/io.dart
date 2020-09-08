import 'pharmacon.dart';

// import 'wiki_page.dart';
import 'dart:io';
// import 'package:dartpedia/dartpedia.dart' as wiki;

import 'wiki_de.dart';
import 'wikipedia.dart';

Future<Pharmacon> loadPharmaconFromWiki({String language, String title}) async {
  String content = await Wikipedia(language).page(title);
  File('text.txt').writeAsStringSync(content);
  WikiDE page = WikiDE(text: content);
  return Pharmacon()
    ..INN = page.INN
    // ..tradeNames.add(name)
    ..ATC = page.ATC
    ..CAS = page.CAS
    ..formula = page.formula
    ..group = page.group;
}

String cacheFolder = '../cache';
Pharmacon loadPharmaconFromCache({String language, String title}) {
  File cache = File('$cacheFolder/$language/$title.json');
  if (cache.existsSync())
    return Pharmacon.fromJson(cache.readAsStringSync());
  else
    return Pharmacon();
}

Future<Pharmacon> loadPharmacon({String language, String query}) async {
  Pharmacon pharmacon = Pharmacon();

  // create cache folder
  Directory('$cacheFolder/$language/').createSync();

  // try to find pharmacon in cache
  pharmacon = loadPharmaconFromCache(language: language, title: query);
  if (pharmacon.INN.length == 0) {
    String title = await Wikipedia(language).search(query);
    pharmacon = loadPharmaconFromCache(language: language, title: title)
      ..INN = title.toLowerCase()
      ..tradeNames.add(query);
  }
  print(pharmacon.JSON);

  File cache = File('$cacheFolder/$language/${pharmacon.INN}.json');
  int cacheAge = cache.existsSync()
      ? DateTime.now().difference(cache.lastModifiedSync()).inSeconds
      : 1000;
  print('cache age: ' + cacheAge.toString());
  if (cacheAge > 10) {
    print("load from network");
    pharmacon +=
        await loadPharmaconFromWiki(language: language, title: pharmacon.INN);
  }
  cache.writeAsStringSync(pharmacon.JSON);
  return pharmacon;
}
