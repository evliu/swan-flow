import 'bitcoin_price_object.dart';
import 'bitcoin_price_service.dart';

class BitcoinPriceController {
  BitcoinPriceController(this._priceService);

  final BitcoinPriceService _priceService;

  init() {
    _priceService.fetchBitcoinPrice();
    _priceService.startRefreshing();
  }

  dispose() {
    _priceService.stopRefreshing();
    _priceService.dispose();
  }

  Stream<BitcoinPrice> get priceStream => _priceService.priceStream;
}
