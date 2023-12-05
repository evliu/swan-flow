import 'package:flutter/material.dart';

class PriceDisplay extends StatefulWidget {
  final double price;
  final TextStyle style;

  const PriceDisplay(
      {required Key super.key, required this.price, required this.style});

  @override
  State<PriceDisplay> createState() => _PriceDisplayState();
}

class _PriceDisplayState extends State<PriceDisplay> {
  @override
  Widget build(BuildContext context) =>
      Text('\$${widget.price.toStringAsFixed(2)}', style: widget.style);
}
