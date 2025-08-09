import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.type,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final AppButtonType? type;

  final Color? backgroundColor;
  final Color? foregroundColor;

  factory AppButton.primary({
    required Widget child,
    required VoidCallback onPressed,
    bool isEnabled = true,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return AppButton(
      onPressed: onPressed,
      type: AppButtonType.primary,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: child,
    );
  }

  factory AppButton.secondary({
    required Widget child,
    required VoidCallback onPressed,
    bool isEnabled = true,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return AppButton(
      onPressed: onPressed,
      type: AppButtonType.secondary,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? _getBackgroundColor(context);
    final foregroundColor =
        onPressed == null ? context.theme.colorScheme.onSurface : context.theme.colorScheme.onPrimary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor, foregroundColor: foregroundColor),
      child: child,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (onPressed == null) return context.theme.colorScheme.surfaceContainer;

    return switch (type) {
      AppButtonType.primary => context.theme.colorScheme.primary,
      AppButtonType.secondary => context.theme.colorScheme.secondary,
      null => context.theme.colorScheme.primary,
    };
  }
}

enum AppButtonType { primary, secondary }
