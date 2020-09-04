import 'dart:convert';

/// Pharmcon Information
class Pharmacon {
  /// International nonproprietary name
  ///
  /// https://en.wikipedia.org/wiki/International_nonproprietary_name
  String INN;

  /// Multiple Trade Names per active ingredient
  List<String> tradeNames;

  /// chemical formula
  String formula;

  /// Chemical Abstracts Service Number
  ///
  /// https://en.wikipedia.org/wiki/CAS_Registry_Number
  List<String> CAS;

  /// Anatomical Therapeutic Chemical Classification System
  ///
  /// https://en.wikipedia.org/wiki/Anatomical_Therapeutic_Chemical_Classification_System
  List<String> ATC;

  Pharmacon({this.INN, this.ATC, this.CAS, this.tradeNames, this.formula});

  /// auxilliary function for internal jsonEncoder
  Map toJson() => {
        'INN': INN,
        'tradeNames': tradeNames ?? [],
        'ATC': ATC,
        'CAS': CAS,
        'formula': formula
      };

  /// returns a pretty printed JSON
  String get JSON => JsonEncoder.withIndent('\t').convert(this);

  @override
  String toString() {
    return "Pharmacon $INN";
  }
}
