import 'package:flutter/material.dart';
import 'package:swan_bitcoin_challenge/bitcoinPriceService.dart';

void main() => runApp(const SwanChallengeApp());

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
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0074C7) // swan colors TrueBlue,
              ),
          headlineMedium: TextStyle(
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
        title: const Text('Swan Challenge'),
      ),
      body: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bitcoinPriceService = BitcoinPriceService();
  @override
  void initState() {
    super.initState();
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
    return StreamBuilder<double>(
      stream: bitcoinPriceService.priceStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bitcoin price',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '\$${snapshot.data!.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                // Button to refresh the price
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        const Color(0xFF0074C7), // swan colors TrueBlue,
                  ),
                  onPressed: () => bitcoinPriceService.fetchBitcoinPrice(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      bitcoinPriceService.isLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.refresh),
                      const SizedBox(width: 8),
                      Text(
                        'Last updated: ${bitcoinPriceService.lastUpdated}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
