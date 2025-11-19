import 'package:flutter/material.dart';

class Imagines extends StatelessWidget {
  const Imagines({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
