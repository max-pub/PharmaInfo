import 'dart:convert';

/// Pharmcon Information
class Pharmacon {
  /// International nonproprietary name
  ///
  /// https://en.wikipedia.org/wiki/International_nonproprietary_name
  String INN = "";

  /// Multiple Trade Names per active ingredient
  Set<String> tradeNames = {};

  /// chemical formula
  Set<String> formula = {};

  /// Chemical Abstracts Service Number
  ///
  /// https://en.wikipedia.org/wiki/CAS_Registry_Number
  Set<String> CAS = {};

  /// Anatomical Therapeutic Chemical Classification System
  ///
  /// https://en.wikipedia.org/wiki/Anatomical_Therapeutic_Chemical_Classification_System
  Set<String> ATC = {};

  Set<String> group = {};

  // Pharmacon({this.INN = '', this.ATC={''}, this.CAS={}, this.tradeNames = {}, this.formula = {}});
  Pharmacon() {}

  /// auxilliary function for internal jsonEncoder
  Map toJson() => {
        'INN': INN,
        if (tradeNames.length > 0) 'tradeNames': tradeNames.toList(),
        if (ATC.length > 0) 'ATC': ATC.toList(),
        if (CAS.length > 0) 'CAS': CAS.toList(),
        if (formula.length > 0) 'formula': formula.toList(),
        if (group.length > 0) 'group': group.toList(),
      };

  /// returns a pretty printed JSON
  String get JSON => JsonEncoder.withIndent('\t').convert(this);

  Pharmacon.fromJson(String json) {
    // print("source");
    // print(json);
    var data = jsonDecode(json);
    if (data['INN'] != null) INN = data['INN'];
    if (data['tradeNames'] != null)
      tradeNames = (data['tradeNames'] as List).map((e) => e.toString()).toSet();
    if (data['ATC'] != null)
      ATC = (data['ATC'] as List).map((e) => e.toString()).toSet();
    if (data['CAS'] != null)
      CAS = (data['CAS'] as List).map((e) => e.toString()).toSet();
    if (data['group'] != null)
      group = (data['group'] as List).map((e) => e.toString()).toSet();
  }

  @override
  String toString() {
    return "Pharmacon $INN $ATC";
  }

  Pharmacon operator +(Pharmacon other) {
    // if(INN != other.INN) throw Exception();
    // print('add pharma');
    // print(this);
    // print(other);
    return Pharmacon.fromJson(this.JSON)
      ..INN = other.INN
      ..CAS.addAll(other.CAS)
      ..ATC.addAll(other.ATC)
      ..formula.addAll(other.formula)
      ..group.addAll(other.group)
      ..tradeNames.addAll(other.tradeNames);
  }
}
