import 'package:firestore_builder_devtools_extension/buttons/tile_button.dart';
import 'package:flutter/material.dart';

class AddFieldButton extends StatelessWidget {
  const AddFieldButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TileButton.add(
      text: 'Add field',
      onTap: () async {},
    );
  }
}
