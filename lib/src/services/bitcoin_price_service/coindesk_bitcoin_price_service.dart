import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'bitcoin_price_object.dart';
import 'bitcoin_price_service.dart';

final _coindeskUri = Uri.parse(
    'https://production.api.coindesk.com/v2/tb/price/ticker?assets=BTC');

class CoindeskBitcoinPriceService implements BitcoinPriceService {
  @override
  Future<BitcoinPrice> fetchBitcoinPrice() async {
    try {
      final response = await http.get(_coindeskUri);

      if (response.statusCode == 200) {
        return fromCoinDeskJson(jsonDecode(response.body)['data']);
      } else {
        return BitcoinPrice(
          price: 0,
          changePercent: 0,
          changeValue: 0,
          dateTime: DateTime.now(),
        );
      }
    } catch (e) {
      print('Error fetching bitcoin price: $e');
      rethrow;
    }
  }
}

/// Utility function to convert the CoinDesk JSON to a [BitcoinPrice] object.
BitcoinPrice fromCoinDeskJson(Map<String, dynamic> json) {
  final price = json['BTC']['ohlc']['c'] as double;
  final changePercent = json['BTC']['change']['percent'] as double;
  final changeValue = json['BTC']['change']['value'] as double;
  final ts = json['BTC']['ts'] as int;
  final dateTime = DateTime.fromMillisecondsSinceEpoch(ts);

  return BitcoinPrice(
    price: price,
    changePercent: changePercent,
    changeValue: changeValue,
    dateTime: dateTime,
  );
}
