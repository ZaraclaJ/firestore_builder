import 'dart:developer' as d;

class Logger {
  static void log(String message) {
    d.log(message, name: 'Firestore Builder');
  }
}
