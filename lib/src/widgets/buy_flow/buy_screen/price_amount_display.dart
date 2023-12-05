import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/bitcoin_price_service/bitcoin_price_controller.dart';

class PriceAmountDisplay extends StatelessWidget {
  final double entered;

  const PriceAmountDisplay({super.key, required this.entered});

  @override
  Widget build(BuildContext context) {
    return Consumer<BitcoinPriceController>(
      builder: (context, bitcoinPriceController, snapshot) {
        var price = bitcoinPriceController.bitcoinPrice.price;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1 BTC ≈ ${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.white38),
            ),
            Text(
              'You will receive ${(entered / price).toStringAsFixed(8)} BTC',
              style: const TextStyle(fontSize: 20, color: Colors.white38),
            ),
          ],
        );
      },
    );
  }
}
