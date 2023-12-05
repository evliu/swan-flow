import 'bitcoin_price_object.dart';

abstract class BitcoinPriceService {
  bool get isLoading;
  String get lastUpdated;

  void startRefreshing();
  void stopRefreshing();
  void dispose();

  void fetchBitcoinPrice();

  Stream<BitcoinPrice> get priceStream;
}
