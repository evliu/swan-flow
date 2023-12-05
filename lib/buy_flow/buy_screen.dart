import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class BuyScreen extends StatefulWidget {
  final double price;

  const BuyScreen({super.key, required this.price});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: SwanColors.coolBlue.value,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Buy ',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: Colors.white38,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      )
                    ],
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'in Bitcoin',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Text(
              '1 BTC ≈ ${widget.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.white38),
            ),
            const Spacer(),
            const Center(child: PreviewBuyButton()),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PreviewBuyButton extends StatelessWidget {
  const PreviewBuyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => Navigator.pushNamed(context, 'preview'),
      style: goldenButtonStyle,
      child: const Text(
        'Preview Buy',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
