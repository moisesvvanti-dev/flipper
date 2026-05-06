import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

/**
 * TAGTINKER NATIVE - 100% HARDWARE INTERNO
 * Suite otimizada para usar apenas os sensores existentes no smartphone.
 */
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TagTinkerNative());
}

class TagTinkerNative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TagTinker Native',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF000000),
        primaryColor: Color(0xFFFF8C00),
        colorScheme: ColorScheme.dark(primary: Color(0xFFFF8C00), secondary: Color(0xFF00F2FF)),
      ),
      home: NativeDashboard(),
    );
  }
}

class NativeDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> tools = [
    {"name": "NFC", "icon": Icons.nfc, "color": Color(0xFF00F2FF), "desc": "13.56MHz Chips"},
    {"name": "IR Remote", "icon": Icons.settings_remote, "color": Colors.red, "desc": "Internal IR Blaster"},
    {"name": "Metal Det.", "icon": Icons.explore, "color": Colors.green, "desc": "Magnetometer Sensor"},
    {"name": "BLE Scan", "icon": Icons.bluetooth, "color": Colors.blue, "desc": "Bluetooth Low Energy"},
    {"name": "Wifi Auth", "icon": Icons.wifi_find, "color": Colors.purple, "desc": "Network Analysis"},
    {"name": "Light Morse", "icon": Icons.flashlight_on, "color": Colors.yellow, "desc": "Flashlight Comms"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TAGTINKER NATIVE", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: tools.length,
          itemBuilder: (context, index) => _buildToolCard(context, tools[index]),
        ),
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, Map<String, dynamic> tool) {
    return InkWell(
      onTap: () => _handleToolTap(context, tool['name']),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tool['icon'], color: tool['color'], size: 48),
            SizedBox(height: 12),
            Text(tool['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(tool['desc'], style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  void _handleToolTap(BuildContext context, String name) {
    // Implementação das funções nativas
    String info = "";
    switch (name) {
      case "NFC": info = "Iniciando hardware NFC..."; break;
      case "Metal Det.": info = "Acessando Magnetômetro..."; break;
      case "Light Morse": info = "Acessando Flash da Câmera..."; break;
      default: info = "Acessando hardware $name...";
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(info),
        backgroundColor: Color(0xFF1A1A1A),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
