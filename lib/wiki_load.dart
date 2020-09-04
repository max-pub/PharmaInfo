import 'pharmacon.dart';
import 'package:http/http.dart' as http;
import 'wiki_page.dart';

/// load and parse a Wikipedia page
Future<Pharmacon> loadPharmacon({language, name}) async {
  final response = await http.get('https://$language.wikipedia.org/wiki/$name');

  WikiPage page = WikiPage.fromHTML(response.body);

  return Pharmacon(
      INN: name,
      CAS: page.CAS,
      ATC: page.ATC,
      // tradeNames: ['bla bla'],
      formula: page.formula);
}
