import 'dart:math';

String getRandomLabel() {
  final randomIndex = Random().nextInt(_labelList.length);
  final user = _labelList[randomIndex];
  return user;
}

const _labelList = [
  'Efficient',
  'Collaborative',
  'Innovative',
  'Goal-oriented',
  'Customer-focused',
  'Results-driven',
  'Adaptive',
  'Communicative',
  'Proactive',
  'High-performing',
  'Creative',
  'Strategic',
  'Agile',
  'Supportive',
  'Trustworthy',
  'Resilient',
  'Diverse',
  'Empowered',
  'Problem-solving',
  'Self-motivated',
  'Ethical',
  'Transparent',
  'Dedicated',
  'Accountable',
  'Continuous learners',
];
