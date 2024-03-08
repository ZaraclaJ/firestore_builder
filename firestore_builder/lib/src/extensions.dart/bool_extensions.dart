extension BoolExtensions on bool {
  int compareTo(bool other) {
    return this == other
        ? 0
        : this
            ? -1
            : 1;
  }
}
