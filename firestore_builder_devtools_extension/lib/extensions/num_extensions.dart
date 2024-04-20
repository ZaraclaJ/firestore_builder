extension NumExtensions on num {
  num bounded(double min, double max) {
    return clamp(min, max);
  }
}

extension DoubleExtensions on double {
  double bounded(double min, double max) {
    return clamp(min, max).toDouble();
  }
}

extension IntExtensions on int {
  int bounded(int min, int max) {
    return clamp(min, max).toInt();
  }
}
