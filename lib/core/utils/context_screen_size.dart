import 'package:flutter/material.dart';

enum WindowSize {
  small,
  medium,
  large,
}

extension ContextScreenSize on BuildContext {
  WindowSize get windowSize {
    var width = MediaQuery.of(this).size.width;
    if (width >= 1280) return WindowSize.large;
    if (width >= 768) return WindowSize.medium;

    return WindowSize.small;
  }

  bool get isSmallWindow {
    return windowSize == WindowSize.small;
  }

  bool get isMediumWindow {
    return windowSize == WindowSize.medium;
  }

  bool get isLargeWindow {
    return windowSize == WindowSize.large;
  }
}
