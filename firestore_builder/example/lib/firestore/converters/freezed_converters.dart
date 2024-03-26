import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}

class TimestampConverter implements JsonConverter<Timestamp, Timestamp> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Timestamp timestamp) {
    return timestamp;
  }

  @override
  Timestamp toJson(Timestamp timestamp) {
    return timestamp;
  }
}
