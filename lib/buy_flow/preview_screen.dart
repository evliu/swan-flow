import 'package:flutter/material.dart';

import '../constants.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SwanColors.coolBlue.value,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text('Preview Buy')),
    );
  }
}
