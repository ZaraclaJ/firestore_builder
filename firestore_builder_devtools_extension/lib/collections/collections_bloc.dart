import 'package:firestore_builder_devtools_extension/collections/start_collection_button.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
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
              child: _CollectionList(),
            ),
            AppDivider.vertical(),
            Expanded(
              child: SizedBox(),
            ),
            AppDivider.vertical(),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionList extends StatelessWidget {
  const _CollectionList();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const StartCollectionButton();
        }
        return null;
      },
    );
  }
}
