import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'buy_bitcoin_text_field.dart';
import 'preview_buy_button.dart';
import 'price_amount_display.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  double entered = 0;
  bool isSubmitting = false;

  void _onValueChanged(String val) {
    if (val.isEmpty) val = '0';

    setState(() => entered = double.parse(val));
  }

  void _onSubmitPressed(context) async {
    setState(() => isSubmitting = true);

    // TODO: Confirm validity of order through a service,
    // then navigate to preview screen if valid, otherwise show error

    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushNamed('preview');

    setState(() => isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: SwanColors.coolBlue.value,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuyBitcoinTextField(onValueChanged: _onValueChanged),
            PriceAmountDisplay(entered: entered),
            const Spacer(),
            Center(
              child: PreviewBuyButton(
                isDisabled: entered == 0,
                isLoading: isSubmitting,
                onPressed: () => _onSubmitPressed(context),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
