import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'services/bitcoin_price_service/bitcoin_price_controller.dart';
import 'services/bitcoin_price_service/coindesk_bitcoin_price_service.dart';

Widget setupApp() {
  return ChangeNotifierProvider(
    create: (context) => BitcoinPriceController(CoindeskBitcoinPriceService()),
    child: const SwanChallengeApp(),
  );
}
