import 'package:http/http.dart' as http;
import 'dart:convert';

class Wikipedia {
  String language = 'de';

  Wikipedia(this.language);

  /// search wikipedia and return the title of the first result
  Future<String> search(String query) async {
    final searchRequest = await http.get(
        'https://$language.wikipedia.org/w/api.php?action=query&list=search&srsearch=$query&format=json');
    return jsonDecode(searchRequest.body)['query']['search'][0]['title'];
  }

  /// load the content of a Wikipedia page
  Future<String> page(String title) async {
    final contentRequest = await http.get(
        'https://$language.wikipedia.org/w/api.php?action=parse&prop=wikitext&page=$title&format=json');
    return jsonDecode(contentRequest.body)['parse']['wikitext']['*'];
  }
}
