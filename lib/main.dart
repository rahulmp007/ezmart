import 'package:ezmart/src/app.dart';
import 'package:ezmart/src/app/startup/initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializer();
}
