import 'package:finalx/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeginScreen extends StatelessWidget {
  BeginScreen({Key? key}) : super(key: key);

  final _controller = TextEditingController(text: "esp.local");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.url,
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Host",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          TextButton(
            onPressed: () {
              final host = _controller.text;
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => DashboardScreen(host: host)));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.12)),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
