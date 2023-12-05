import 'bitcoin_price_object.dart';

abstract class BitcoinPriceService {
  Future<BitcoinPrice> fetchBitcoinPrice();
}
