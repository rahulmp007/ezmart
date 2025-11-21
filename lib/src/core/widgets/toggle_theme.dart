import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.light_mode, color: Colors.white),
      onPressed: () {},

      tooltip: 'Switch theme',
    );
  }
}
