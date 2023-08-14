import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/screens/result_screen.dart';

const bgColor = Color(0xfffafafa);

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  bool isScannedCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScannedCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  // works as toggle
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                controller.switchCamera();
              },
              icon: Icon(
                Icons.camera_front,
                color: isFrontCamera ? Colors.blue : Colors.grey,
              )),
        ],
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
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Place your QR Code In The Area",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Scanning Will Be Started Automatically",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            )),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      child: MobileScanner(
                        overlay: QRScannerOverlay(),
                        controller: controller,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          // final Uint8List? image = capture.image;
                          for (final barcode in barcodes) {
                            debugPrint('Barcode found! ${barcode.rawValue}');
                            String code = barcode.rawValue ?? "---";
                            if (!isScannedCompleted) {
                              isScannedCompleted = true;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                    closeScreen: closeScreen,
                                    code: code,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.catching_pokemon,
                size: 30,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class QRScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.7, // Adjust the width as needed
        height: MediaQuery.of(context).size.width *
            0.7, // Adjust the height as needed
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
