extension DoubleExtensions on double {
  double bounded(double min, double max) {
    return clamp(min, max).toDouble();
  }
}
