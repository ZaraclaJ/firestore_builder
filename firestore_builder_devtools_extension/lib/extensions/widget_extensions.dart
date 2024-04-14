import 'package:flutter/widgets.dart';

extension WidgetListExt on Iterable<Widget> {
  List<Widget> joinWidgets(Widget separator) {
    final currentList = this;
    return [
      for (var i = 0; i < currentList.length; i++) ...[
        if (i != 0) separator,
        currentList.elementAt(i),
      ],
    ];
  }
}
