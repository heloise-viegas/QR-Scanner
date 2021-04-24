import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: QrScan(),
      darkTheme: ThemeData.dark().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.blueGrey,
        ),
        // accentColor: Colors.blueGrey,
      ),
    ),
  );
}

class QrScan extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String result = "You're scan result will appear here.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('QR Scanner'),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.blueGrey,
          child: Text(
            result,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          label: Text('Scan'),
          onPressed: () {
            _scanQR();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future _scanQR() async {
    try {
      ScanResult qrCode = await BarcodeScanner.scan();
      setState(() {
        result = qrCode.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera Access Denied.";
        });
      } else {
        setState(() {
          result = "Unknown error.$e";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown error.$ex";
      });
    }
  }
}
