import 'apis.dart';

abstract class UnitsAndFactors {
  Future<Map<String, dynamic>> fetchUnitsAndFactors();
}

class CurrencyUnits implements UnitsAndFactors {
  @override
  Future<Map<String, dynamic>> fetchUnitsAndFactors() async {
    final result = await CurrencyApi.fetchRates();
    final date = result['date'];
    final unitToRates = result['rates'];
    final units = unitToRates.keys.toList();

    return {'units': units, 'unitToRates': unitToRates, 'date': date};
  }
}
