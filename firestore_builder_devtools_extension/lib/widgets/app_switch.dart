import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    this.onChanged,
    super.key,
  });

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Icon(Icons.check);
          }
          return const Icon(Icons.close);
        },
      ),
      onChanged: onChanged,
    );
  }
}
