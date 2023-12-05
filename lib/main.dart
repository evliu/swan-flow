import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swan_bitcoin_challenge/services/bitcoin_price_service/bitcoin_price_object.dart';

import 'bitcoinChartView.dart';
import 'services/bitcoin_price_service/coindesk_bitcoin_price_service.dart';
import 'buy_flow/buy_navigator.dart';
import 'constants.dart';
import 'widgets/buy_bitcoin_button.dart';

void main() {
  runApp(const SwanChallengeApp());
}

// ignore: slash_for_doc_comments
/**
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

class SwanChallengeApp extends StatelessWidget {
  const SwanChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swan Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: SwanColors.coolBlue.value,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: SwanColors.trueBlue.value,
          ),
          headlineMedium: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Swan Challenge',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: SwanColors.coolBlue.value,
      ),
      body: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bitcoinPriceService = CoindeskBitcoinPriceService();

  @override
  void initState() {
    super.initState();
    bitcoinPriceService.fetchBitcoinPrice();
    bitcoinPriceService.startRefreshing();
  }

  @override
  void dispose() {
    bitcoinPriceService.stopRefreshing();
    bitcoinPriceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BitcoinPrice>(
      stream: bitcoinPriceService.priceStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data!;
          final price = item.price;
          final changePercent = item.changePercent;
          final changeValue = item.changeValue;
          final isUp = changePercent >= 0;
          final lastUpdated = item.formattedDate;

          print(' price: $price');

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
                const Expanded(
                  flex: 4,
                  child: Card(
                    margin: EdgeInsets.all(16),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BitcoinChartUI(),
                    ),
                  ),
                ),
                const Spacer(),
                BuyButton(openTo: BuyNavigator(price: price)),
                const Spacer(),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
