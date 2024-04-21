import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _isHoverProvider = StateProvider.autoDispose<bool>(
  (ref) => throw UnimplementedError(),
);

class OnHoverBuilder extends StatelessWidget {
  const OnHoverBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(bool value) builder;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        _isHoverProvider.overrideWith((ref) => false),
      ],
      child: Consumer(
        builder: (context, ref, _) {
          final isHover = ref.watch(_isHoverProvider);
          return Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Colors.red,
              onHover: (value) {
                ref.read(_isHoverProvider.notifier).state = value;
              },
              onTap: () {},
              child: builder(isHover),
            ),
          );
        },
      ),
    );
  }
}
