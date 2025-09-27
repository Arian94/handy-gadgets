import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// CurrencyApi provides methods to fetch latest currency rates and available currency codes
/// from the Frankfurter API. Use this class for real-time currency conversion data.
class CurrencyApi {
  static const String baseUrl = 'https://api.frankfurter.app';
  static CancelableOperation? _fetchTimeSeriesOperation;

  /// Fetches currency abbreviations and their complete names.
  static Future<Map<String, dynamic>> fetchCurrencyNames() async {
    final response = await http.get(Uri.parse('$baseUrl/currencies'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // final names = Map<String, String>.from(data);
      return data;
    } else {
      throw Exception('Failed to fetch currency rates');
    }
  }

  /// Fetches currency rates and returns a map with 'rates' and 'date'.
  static Future<Map<String, dynamic>> fetchRates({String base = 'USD'}) async {
    final response = await http.get(Uri.parse('$baseUrl/latest?from=$base'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = Map<String, double>.from(data['rates']);
      rates[base] = 1;
      final date = data['date'] as String;
      return {'rates': rates, 'date': date};
    } else {
      throw Exception('Failed to fetch currency rates');
    }
  }

  /// Fetches currency codes (names) from the rates API.
  static Future<List<String>> fetchCurrencyCodes({String base = 'USD'}) async {
    final result = await fetchRates(base: base);
    (result['units'] as List<String>).add(base);
    final rates = result['rates'] as Map<String, double>;
    return rates.keys.toList();
  }

  /// Fetches time series rates for a currency pair between start and end dates.
  /// Returns a map: { 'rates': {date: rate, ...}, 'start': startDate, 'end': endDate }
  static Future<Map<String, dynamic>> fetchTimeSeries({
    required String base,
    required String target,
    required String startDate,
    required String endDate,
  }) async {
    _fetchTimeSeriesOperation?.cancel();

    final url = '$baseUrl/$startDate..$endDate?from=$base&to=$target';
    _fetchTimeSeriesOperation = CancelableOperation.fromFuture(
      http.get(Uri.parse(url)),
      onCancel: () {
        if (kDebugMode) {
          print("request cancelled.");
        }
      },
    );
    // final response = await http.get(Uri.parse(url));
    final response = await _fetchTimeSeriesOperation!.value;
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = Map<String, double>.fromEntries(
        (data['rates'] as Map<String, dynamic>).entries.map(
          (e) => MapEntry(e.key, (e.value as Map)[target] as double),
        ),
      );
      return {
        'rates': rates, // {date: rate}
        'start': data['start_date'],
        'end': data['end_date'],
        'base': base,
        'target': target,
      };
    } else {
      throw Exception('Failed to fetch historical currency rates');
    }
  }
}
