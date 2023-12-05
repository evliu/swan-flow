import 'dart:async';

import 'package:flutter/material.dart';

import 'bitcoin_price_object.dart';
import 'bitcoin_price_service.dart';

class BitcoinPriceController extends ChangeNotifier {
  final BitcoinPriceService _priceService;
  late BitcoinPrice _bitcoinPrice = BitcoinPrice.empty();
  Timer? _timer;

  BitcoinPriceController(this._priceService) {
    fetchBitcoinPrice();
    startRefreshing();
  }

  BitcoinPrice get bitcoinPrice => _bitcoinPrice;

  fetchBitcoinPrice() async {
    _bitcoinPrice = await _priceService.fetchBitcoinPrice();
    print(' Bitcoin price: \$${_bitcoinPrice.price.toStringAsFixed(2)}');
    notifyListeners();
  }

  startRefreshing() => _timer =
      Timer.periodic(const Duration(seconds: 5), (_) => fetchBitcoinPrice());

  stopRefreshing() => _timer?.cancel();

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
