import 'package:flutter/material.dart';

import '../../constants.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: SwanColors.coolBlue.value,
      child: Column(
        children: [
          Text(
            'Preview Screen',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
