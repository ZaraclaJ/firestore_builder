import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:flutter/material.dart';

class CollectionsBloc extends StatelessWidget {
  const CollectionsBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPadding.regular(
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Text('data'),
            ),
            VerticalDivider(),
            Expanded(
              child: Text('data'),
            ),
            VerticalDivider(),
            Expanded(
              child: Text('data'),
            ),
          ],
        ),
      ),
    );
  }
}
