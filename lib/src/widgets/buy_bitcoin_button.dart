import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({super.key, required this.openTo});

  final Widget openTo;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 600),
      transitionType: ContainerTransitionType.fadeThrough,
      openColor: SwanColors.coolBlue.value,
      closedColor: SwanColors.coolBlue.value,
      middleColor: SwanColors.coolBlue.value,
      closedElevation: 8,
      closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(48))),
      closedBuilder: closedBuilder,
      openBuilder: openBuilder,
    );
  }

  Widget openBuilder(BuildContext c, VoidCallback action) => openTo;

  Widget closedBuilder(BuildContext c, VoidCallback action) => ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(SwanColors.coolBlue.value),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          fixedSize: MaterialStateProperty.all<Size>(const Size(200, 48)),
        ),
        onPressed: action,
        child: const Text('Buy Bitcoin', style: TextStyle(fontSize: 24)),
      );
}
