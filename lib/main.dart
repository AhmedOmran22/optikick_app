import 'package:flutter/material.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/optikick_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();

  runApp(const OptikickApp());
}

