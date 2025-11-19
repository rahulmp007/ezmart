import 'dart:developer';
import 'package:ezmart/src/features/product/data/model/product_model.dart';
import 'package:ezmart/src/features/product/data/model/rating_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);
      Hive.registerAdapter(ProductModelAdapter());
      Hive.registerAdapter(RatingModelAdapter());
    } on Exception catch (e) {
      log('hive init error: $e');
    }
  }
}
