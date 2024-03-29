import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/message.dart';

Message getRandomMessage() {
  final date = DateTime.now();
  final timestamp = Timestamp.fromDate(date);
  final randomIndex = Random().nextInt(_messageList.length);
  return Message(content: _messageList[randomIndex], date: timestamp);
}

final _messageList = [
  'Hello',
  'Hi',
  'How are you?',
  'I am fine',
  'Good morning',
  'Good night',
  'Good evening',
  'Good morning! Hope you have a fantastic day ahead!',
  "Just wanted to say hello and see how you're doing.",
  'Sending positive vibes your way!',
  'Remember to take breaks and take care of yourself.',
  "You're capable of amazing things. Keep going!",
  "Don't forget to smile today. You deserve happiness.",
  "If you're feeling overwhelmed, it's okay to ask for help.",
  "You've got this! Believe in yourself.",
  'Wishing you a productive and fulfilling day.',
  "Hey there! Just checking in to see how you're feeling.",
  "You're stronger than you think. Keep pushing forward.",
  'Sending virtual hugs your way!',
  'Hope today brings you moments of joy and laughter.',
  'Remember to be kind to yourself.',
  'You are loved and appreciated.',
  "Don't let setbacks discourage you. Every step forward counts.",
  'Take a deep breath and tackle one thing at a time.',
  "You're making progress, even if it doesn't feel like it.",
  'Keep your head up. Brighter days are ahead.',
  "You're not alone. I'm here for you.",
  'Believe in the power of your dreams.',
  "Chin up, buttercup! You've got this.",
  'Your hard work will pay off. Keep going!',
  'Embrace the challenges. They make you stronger.',
  'Sending you strength and courage to face the day.',
  "Don't forget to celebrate even the small victories.",
  'Keep a positive mindset. It can change your whole day.',
  'Your potential is limitless. Keep reaching for the stars.',
  "Hey, just wanted to remind you that you're amazing!",
  'Believe in yourself, and anything is possible.',
  "Stay focused on your goals. You're closer than you think.",
  'Life is tough, but so are you. Keep persevering.',
  'You are enough, just as you are.',
  'Every day is a new opportunity for growth and progress.',
  'Keep shining bright. The world needs your light.',
  "Don't let fear hold you back. You're capable of greatness.",
  'Stay true to yourself, and amazing things will happen.',
  "You're making a difference, even if you don't realize it.",
  'Believe in the beauty of your dreams.',
  "You're on the right path. Keep moving forward.",
  'Your journey matters. Embrace every step of it.',
  'Sending you a burst of positivity and encouragement!',
  'You have the power to create the life you want.',
  "Hey, just wanted to say you're doing great!",
  'Your strength inspires those around you.',
  "Keep being your wonderful self. You're making a difference.",
  "You're not defined by your past. Your future is full of possibilities.",
  'Remember, you are loved, you are worthy, and you are enough.',
];
