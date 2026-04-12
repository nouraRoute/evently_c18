import 'package:flutter/material.dart';

class SharedContainerDecoration {
  static BoxDecoration decorationWithBorder(ThemeData theme) => BoxDecoration(
    border: Border.all(color: theme.dividerColor),

    borderRadius: BorderRadius.circular(8),
  );
}
