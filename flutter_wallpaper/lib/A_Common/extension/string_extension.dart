
import 'dart:ui';
import 'color_extension.dart';

extension StringExt on String {
  Color get hexColor {
    var hexColorString = this;
    if (hexColorString.contains("#")) {
      hexColorString = hexColorString.replaceFirst("#", "");
    }
    return ColorExt.colorHex(hexColorString);
  }
}
