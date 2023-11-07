import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:multi_vendor_admin_web/views/mainAdmin.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid ? FirebaseOptions(apiKey: 'AIzaSyDdVrU9uczKg6G8VWIwehNk6FZyjVYCPcE', appId: "1:514515683759:web:b11bfb9101d5c8f342475a", messagingSenderId:  "514515683759", projectId: "multi-vendor-store-4b2d5",storageBucket:"multi-vendor-store-4b2d5.appspot.com" ,):null,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Vendor Admin',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AdminPage(),
      builder: EasyLoading.init(),
    );
  }
}
