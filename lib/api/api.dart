import 'package:flutter/painting.dart';
import 'package:http/http.dart';

class Api {
  final String host;

  Api(this.host);

  void setPower(bool state) {
    final route = "http://$host/power?${state ? 1 : 0}";
    get(Uri.parse(route));
  }

  void setPreset() {
    final route = "http://$host/preset";
    get(Uri.parse(route));
  }

  void setColor(Color color, int index) {
    final colorValue = ((color.value & 0xFFFFFF) << 8) + index + 1;
    final route = "http://$host/color?$colorValue";
    get(Uri.parse(route));
  }
}
