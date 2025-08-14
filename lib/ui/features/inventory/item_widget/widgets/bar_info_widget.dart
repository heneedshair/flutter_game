import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class BarInfoWidget extends StatelessWidget {
  const BarInfoWidget({super.key, required this.label, required this.value, required this.extraColor});

  final String label;
  final int value;
  final Color extraColor;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.theme.text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textStyles.titleSmall?.copyWith(
            color: extraColor,
            fontWeight: FontWeight.w900,
            fontSize: 13,
            height: 1,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          '$value',
          maxLines: 1,
          style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w600, fontSize: 13, height: 1),
        ),
      ],
    );
  }
}
