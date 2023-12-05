import 'package:flutter/material.dart';

import '../constants.dart';
import 'buy_screen.dart';
import 'preview_screen.dart';
import 'success_screen.dart';

class BuyNavigator extends StatelessWidget {
  final double price;

  const BuyNavigator({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SwanColors.coolBlue.value,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Navigator(
        initialRoute: 'buy',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case 'buy':
              builder = (BuildContext _) => BuyScreen(price: price);
              break;
            case 'preview':
              builder = (BuildContext _) => const PreviewScreen();
              break;
            case 'success':
              builder = (BuildContext _) => const SuccessScreen();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
