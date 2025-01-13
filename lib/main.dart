import 'package:Voyagr/pages/login.dart';
import 'package:flutter/material.dart';

// import 'package:Voyagr/pages/home.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'component/login.dart'; // Correct import for Comp1

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // darkTheme: ThemeData.dark(),
        home: LoginPage());
  }
}
