import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'bitcoin_price_object.dart';
import 'bitcoin_price_service.dart';

final parse = Uri.parse(
    'https://production.api.coindesk.com/v2/tb/price/ticker?assets=BTC');

class CoindeskBitcoinPriceService implements BitcoinPriceService {
  final _priceStreamController = StreamController<BitcoinPrice>();
  Timer? _timer;
  bool _isLoading = false;
  DateTime? _lastUpdated;

  @override
  bool get isLoading => _isLoading;

  @override
  String get lastUpdated => _lastUpdated != null
      ? DateFormat('h:mm:ssa MM/dd/yyyy').format(_lastUpdated!.toLocal())
      : 'Never';

  @override
  Stream<BitcoinPrice> get priceStream => _priceStreamController.stream;

  @override
  void startRefreshing() {
    _timer =
        Timer.periodic(const Duration(seconds: 5), (_) => _fetchBitcoinPrice());
  }

  @override
  void stopRefreshing() => _timer?.cancel();

  @override
  void fetchBitcoinPrice() => _fetchBitcoinPrice();

  void _fetchBitcoinPrice() async {
    try {
      _isLoading = true;
      final response = await http.get(parse);
      _isLoading = false;
      if (response.statusCode == 200) {
        _priceStreamController.add(
          fromCoinDeskJson(jsonDecode(response.body)['data']),
        );
      }
    } catch (e) {
      print('Error fetching bitcoin price: $e');
    }
  }

  @override
  void dispose() {
    _priceStreamController.close();
    _timer?.cancel();
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

// void main() {
//   final bitcoinPriceService = BitcoinPriceService();

//   // Start refreshing the bitcoin price every 5 seconds
//   bitcoinPriceService.startRefreshing();

//   // Listen to the price stream
//   final subscription = bitcoinPriceService.priceStream.listen((price) {
//     print('Bitcoin price: \$${price.toStringAsFixed(2)}');
//   });

//   // Stop refreshing and dispose the service after 30 seconds
//   Future.delayed(const Duration(seconds: 30), () {
//     bitcoinPriceService.stopRefreshing();
//     bitcoinPriceService.dispose();
//     subscription.cancel();
//   });
// }
