import 'package:finalx/screens/dashboard/panels_drawer.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.host}) : super(key: key);

  final String host;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: PanelDrawerWidget(),
        ),
      ),
    );
  }
}
