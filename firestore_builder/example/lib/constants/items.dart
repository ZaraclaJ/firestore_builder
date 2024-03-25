import 'dart:math';

import 'package:example/firestore/models/item.dart';

Item getRandomItem() {
  final randomIndex = Random().nextInt(_itemList.length);
  return Item(name: _itemList[randomIndex]);
}

const _itemList = [
  'Stapler',
  'Coffee mug',
  'Picture frame',
  'Scissors',
  'Desk lamp',
  'Mouse pad',
  'Plant pot',
  'Sticky notes',
  'Paper clips',
  'Calculator',
  'Tape dispenser',
  'Bookshelf',
  'Pencil holder',
  'Keyboard',
  'Coasters',
  'Calendar',
  'Letter opener',
  'Filing cabinet',
  'Wall clock',
  'USB flash drive',
  'Desk organizer',
  'Tissue box',
  'Coffee maker',
  'Magazine rack',
  'Wireless router',
  'Whiteboard',
  'Post-it flags',
  'Desk calendar',
  'Cork board',
  'Letter tray',
  'Paper shredder',
  'Headphones',
  'Surge protector',
  'Wastebasket',
  'Bookends',
  'Tape measure',
  'File folders',
  'Desk chair',
  'Dry erase markers',
  'Picture frames',
  'Wall art',
  'Desktop computer',
  'Printer',
  'Telephone',
  'Power strip',
  'Coat rack',
  'Calendar',
  'Desk fan',
  'Letter scale',
  'Desk blotter',
];
