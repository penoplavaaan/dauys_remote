import 'dart:io';

import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class SettingsDevicesScanScreen extends StatefulWidget {
  const SettingsDevicesScanScreen({super.key});

  @override
  State<SettingsDevicesScanScreen> createState() => _SettingsDevicesScanScreenState();
}

class _SettingsDevicesScanScreenState extends State<SettingsDevicesScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // } else if (Platform.isIOS) {
    //   controller!.resumeCamera();
    // }
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Сканировать QR'),
          Expanded(
            child: Text('123'),
          ),
        ],
      ),
    );
  }
}
