import 'package:flutter/material.dart';

import '../../../constants.dart';

class PreviewBuyButton extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback onPressed;

  const PreviewBuyButton({
    super.key,
    required this.isLoading,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: isDisabled ? goldenDisabledButtonStyle : goldenButtonStyle,
      child: isLoading
          ? const CircularProgressIndicator.adaptive()
          : const Text(
              'Preview Buy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
    );
  }
}
