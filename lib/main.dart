import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/routes/app_pages.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: '.env.prod');
  } else {
    await dotenv.load(fileName: '.env.dev');
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: AppPages.INITIAL,//màn hình mặc định khi chạy app, được dẫn bằng name router

    locale: const Locale('pt', 'BR'),
    getPages: AppPages.routes
  ));
}

