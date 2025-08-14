import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class RatingIndicator extends StatelessWidget {
  const RatingIndicator({super.key, required this.backgroundColor, required this.value, required this.foregroundColor});

  final Color backgroundColor;
  final Color foregroundColor;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6.2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Text(
        '$value',
        style: context.theme.text.labelMedium?.copyWith(color: foregroundColor, height: 1, fontWeight: FontWeight.w600),
      ),
    );
  }
}
