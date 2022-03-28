import 'package:finalx/api/api.dart';
import 'package:finalx/screens/dashboard/panels_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.host}) : super(key: key);

  final String host;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Color currentPanelColor = Colors.white;
  int selectedPanelIndex = 0;
  bool powered = false;
  late Api api;

  @override
  void initState() {
    super.initState();
    api = Api(widget.host);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FinalX"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PanelDrawerWidget(
            selectedIndex: selectedPanelIndex,
            onSelect: (index) => setState(() => selectedPanelIndex = index),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SwitchListTile(
              title: const Text("Power"),
              value: powered,
              onChanged: (v) {
                api.setPower(v);
                setState(() => powered = v);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              api.setPreset();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.12)),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
            ),
            child: const Text(
              "RAINBOW",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          HueRingPicker(
            pickerColor: currentPanelColor,
            onColorChanged: (color) {
              api.setColor(color, selectedPanelIndex);
              setState(() => currentPanelColor = color);
            },
            hueRingStrokeWidth: 24.0,
          ),
        ],
      ),
    );
  }
}
