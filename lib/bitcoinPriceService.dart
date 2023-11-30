// ignore: slash_for_doc_comments
/**************************************************************
  this url: https://api.coindesk.com/v1/bpi/currentprice/USD.json
  returns this json: {
    "time": {
      "updated": "Nov 29, 2023 22:43:00 UTC",
      "updatedISO": "2023-11-29T22:43:00+00:00",
      "updateduk": "Nov 29, 2023 at 22:43 GMT"
    },
    "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
    "bpi": {
      "USD": {
        "code": "USD",
        "rate": "37,601.7788",
        "description": "United States Dollar",
        "rate_float": 37601.7788
      }
    }
  }
 */

import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BitcoinPriceService {
  final StreamController<double> _priceStreamController =
      StreamController<double>();
  Timer? _timer;
  bool _isLoading = false;
  DateTime? _lastUpdated;

  bool get isLoading => _isLoading;

  String get lastUpdated => _lastUpdated != null
      ? DateFormat('h:mma MM/dd/yyyy').format(_lastUpdated!.toLocal())
      : 'Never';
  Stream<double> get priceStream => _priceStreamController.stream;

  void startRefreshing() {
    _timer =
        Timer.periodic(const Duration(seconds: 5), (_) => _fetchBitcoinPrice());
  }

  void stopRefreshing() => _timer?.cancel();
  void fetchBitcoinPrice() => _fetchBitcoinPrice();

  void _fetchBitcoinPrice() async {
    try {
      _isLoading = true;
      final response = await http.get(
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/USD.json'));
      _isLoading = false;
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final price = json['bpi']['USD']['rate_float'] as double;
        _priceStreamController.add(price);
        _lastUpdated = DateTime.parse(json['time']['updatedISO']);
      }
    } catch (e) {
      print('Error fetching bitcoin price: $e');
    }
  }

  void dispose() {
    _priceStreamController.close();
    _timer?.cancel();
  }
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
