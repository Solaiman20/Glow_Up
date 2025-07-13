import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  getScreenWidth({required double size}) {
    return MediaQuery.sizeOf(this).width * size;
  }

  getScreenHeight({required double size}) {
    return MediaQuery.sizeOf(this).height * size;
  }
}
