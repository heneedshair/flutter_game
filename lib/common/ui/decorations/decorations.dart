import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

abstract final class Decorations {
  static Widget filled({required Widget child, Color? color}) => _Filled(color: color, child: child);

  static Widget withShadow({required Widget child}) => _WithShadow(child: child);

  static Widget withImage({required String imageUrl, required Widget child}) =>
      _WithImage(imageUrl: imageUrl, child: child);
}

class _Filled extends StatelessWidget {
  const _Filled({
    required this.child,
    required this.color,
  });

  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? context.theme.colors.onSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class _WithShadow extends StatelessWidget {
  const _WithShadow({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 6),
            color: context.theme.brightness == Brightness.light
                ? Colors.black.withOpacity(0.17)
                : Colors.white.withOpacity(0.17),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class _WithImage extends StatelessWidget {
  const _WithImage({
    required this.imageUrl,
    required this.child,
  });

  final String imageUrl;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        color: context.theme.colors.onSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
