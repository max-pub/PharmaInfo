import 'package:test/test.dart';
import 'dart:io';
import 'lib/wiki_load.dart';
import 'lib/pharmacon.dart';
import 'dart:convert';

String minimalJSON(JSON) => jsonEncode(jsonDecode(JSON));

testPharmacon({String language, String name}) {
  test('$language $name', () async {
    String test = File('../test/$language.$name.json').readAsStringSync();
    Pharmacon wiki = await loadPharmacon(language: language, name: name);
    expect(minimalJSON(test), equals(minimalJSON(wiki.JSON)));
  });
}

void main() {
  for (File file in Directory('../test').listSync()) {
    print(file);
    List<String> parts =
        file.path.replaceAll('../test/', '').replaceAll('.json', '').split('.');
    // print(parts);
    testPharmacon(language: parts[0], name: parts[1]);
  }
}
