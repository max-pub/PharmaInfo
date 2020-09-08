/// parse a Wikipedia entry

class WikiDE {
  String text;
  WikiDE({this.text});

  Set<String> find(String re) =>
      RegExp(re, caseSensitive: false, multiLine: false)
          .allMatches(this.text)
          .map((e) => e.group(1))
          .where((element) => element != "")
          .toSet();
  Set<String> findKey(String key) => find(r"KEY.*?=(.*)".replaceAll('KEY', key));

  String get INN => findKey('Freiname').join('').trim().toLowerCase();

  Set<String> get ATC =>
      find(r"{{ATC\|(.*?)}}").map((e) => e.replaceAll('|', '')).toSet();

  Set<String> get CAS => findKey('CAS')//find(r"CAS.*?=(.*)")
      .map((e) => e.replaceAll(RegExp(r'[^0-9\-]'), '').trim())
      .toSet();

  // Set<String> get drugBank => find(r"DrugBank.*?=(.*)")
  //     .map((e) => e.replaceAll(RegExp(r'[^0-9\-]'), '').trim())
  //     .where((element) => element != "")
  //     .toSet();

  Set<String> get group =>
      findKey('Wirkstoffgruppe')
          .map((e) => e.replaceAll(RegExp(r'[\[\]]'), '').trim())
          .toSet() ??
      findKey("Wirkstoffklasse")
          .map((e) => e.replaceAll(RegExp(r'[\[\]]'), '').trim())
          .toSet();

  Set<String> get formula => findKey('Suchfunktion')
      .map((e) => e.trim())
      .where((element) => element != "")
      .toSet();
}
