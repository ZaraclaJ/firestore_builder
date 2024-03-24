import 'dart:math';

import 'package:example/firestore/models/user.dart';

User getRandomUser() {
  final randomIndex = Random().nextInt(_userList.length);
  final user = _userList[randomIndex];
  return user;
}

const _userList = [
  User(name: 'Alice', age: 20),
  User(name: 'Thomas ', age: 20),
  User(name: 'John', age: 25),
  User(name: 'Jane', age: 30),
  User(name: 'Doe', age: 35),
  User(name: 'Smith', age: 40),
  User(name: 'Alex', age: 45),
  User(name: 'Alice', age: 50),
  User(name: 'Bob', age: 55),
  User(name: 'Charlie', age: 60),
  User(name: 'Emma', age: 35),
  User(name: 'Noah', age: 15),
  User(name: 'Olivia', age: 45),
  User(name: 'Liam', age: 12),
  User(name: 'Ava', age: 18),
  User(name: 'William', age: 27),
  User(name: 'Sophia', age: 41),
  User(name: 'James', age: 32),
  User(name: 'Isabella', age: 15),
  User(name: 'Benjamin', age: 30),
  User(name: 'Mia', age: 8),
  User(name: 'Mason', age: 62),
  User(name: 'Charlotte', age: 24),
  User(name: 'Elijah', age: 35),
  User(name: 'Amelia', age: 22),
  User(name: 'Oliver', age: 25),
  User(name: 'Harper', age: 15),
  User(name: 'Jacob', age: 43),
  User(name: 'Evelyn', age: 50),
  User(name: 'Ethan', age: 28),
];
