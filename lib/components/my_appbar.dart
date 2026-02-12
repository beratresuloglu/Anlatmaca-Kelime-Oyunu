import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title_;
  final Size preferredSize;

  const MyAppBar({
    super.key,
    required this.title_,
    required this.preferredSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      foregroundColor: theme.appBarTheme.foregroundColor,
      title: Text(title_),
    );
  }
}
