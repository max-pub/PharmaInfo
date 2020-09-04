import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

/// parse a Wikipedia entry
class WikiPage {
  Document document;

  WikiPage(this.document);
  WikiPage.fromHTML(String HTML) {
    document = parse(HTML);
  }

  List<String> get ATC => document
      .querySelector(
          'a[href="/wiki/Anatomisch-Therapeutisch-Chemisches_Klassifikationssystem"]')
      .parent
      .nextElementSibling
      .querySelectorAll('p')
      .map((e) => e.text.trim())
      .toList();

  List<String> get CAS => document
      .querySelector('a[href="/wiki/CAS-Nummer"]')
      .parent
      .nextElementSibling
      .querySelectorAll('li')
      .map((e) => e.text.split(' ')[0].trim())
      // .map((e) => e.text.trim())
      .toList();

  String get formula => document
      .querySelector('a[href="/wiki/Summenformel"]')
      .parent
      .nextElementSibling
      .text
      ?.trim();
}
