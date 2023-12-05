import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuyBitcoinTextField extends StatelessWidget {
  final ValueChanged<String> onValueChanged;

  const BuyBitcoinTextField({super.key, required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                onChanged: onValueChanged,
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
      ],
    );
  }
}
