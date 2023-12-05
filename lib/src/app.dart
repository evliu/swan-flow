/*
 * Create a demo flutter app for buying Bitcoin. Here is the general guideline:

- Show the bitcoin price on the homepage, bonus points for a chart. The bitcoin price must come from a real API (there are several available publicly)
  - the price should be updated every 5 seconds
  - a smLargeime of last refreshed time should be shown on the screen discretely
  - add the ability to refresh the price on demand
  - add a button to navigate to the buy flow
  - use MVVM architecture
- Create a buying flow that has 2 steps
  - Entry screen - user must enter the USD amount of Bitcoin to buy
  - Preview screen - show the information entered on the prior screen and allow the user to go back to edit it provide a “Buy button”
  - when the Buy button is pressed, simulate a network call (spinner/loader state) and load the success screen
  - Success screen

  - use MVVM architecture
  - use SOLID principles
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swan_bitcoin_challenge/src/services/bitcoin_price_service/bitcoin_price_controller.dart';

import 'constants.dart';
import 'widgets/bitcoinChartView.dart';
import 'widgets/buy_bitcoin_button.dart';
import 'widgets/buy_flow/buy_navigator.dart';

class SwanChallengeApp extends StatelessWidget {
  const SwanChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swan Challenge',
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Swan Challenge',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: SwanColors.coolBlue.value,
        ),
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BitcoinPriceDisplay(),
          BitcoinChartDisplay(),
          Spacer(),
          BuyButton(openTo: BuyNavigator()),
          Spacer(),
        ],
      ),
    );
  }
}

class BitcoinPriceDisplay extends StatelessWidget {
  const BitcoinPriceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BitcoinPriceController>(
      builder: (context, bitcoinPriceController, snapshot) {
        final item = bitcoinPriceController.bitcoinPrice;
        final price = item.price;
        final changePercent = item.changePercent;
        final changeValue = item.changeValue;
        final isUp = changePercent >= 0;
        final lastUpdated = item.formattedDate;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bitcoin price',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                '${changePercent.toStringAsFixed(2)}% ${isUp ? '⬆' : '⬇'} \$${changeValue.toStringAsFixed(2)} Today',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isUp ? Colors.greenAccent : Colors.redAccent,
                ),
              ),
              Text(
                'Updated: $lastUpdated',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BitcoinChartDisplay extends StatelessWidget {
  const BitcoinChartDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 4,
      child: Card(
        margin: EdgeInsets.all(16),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: BitcoinChartUI(),
        ),
      ),
    );
  }
}
