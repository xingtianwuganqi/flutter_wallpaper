
import 'package:flutter/rendering.dart';

extension ColorExt on Color {
  /*
  hex 16进制颜色 返回 Color
  * */
   static Color colorHex(String hex) {
    var colorInt = int.parse(hex,radix: 16);
    return Color(colorInt | 0xFF000000);
  }

}