import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/screens/qr_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ResultScreen(
      {super.key, required this.code, required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            closeScreen(
            );
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show qr code here
            QrImageView(
              data: code,
              size: 150,
              version: QrVersions.auto,
            ),

            const Text(
              "Scanned Result",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54,
                  letterSpacing: 1),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black87, letterSpacing: 1),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                },
                child: const Text(
                  "Copy",
                  style: TextStyle(
                      fontSize: 16, color: Colors.black87, letterSpacing: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
