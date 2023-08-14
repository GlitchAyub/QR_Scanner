import 'package:flutter/material.dart';
import 'package:qr_code_scanner/screens/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR-Scanner',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0.0),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const QrScanner(),
    );
  }
}
