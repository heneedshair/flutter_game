import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class SpecBarWidget extends StatelessWidget {
  final int value;
  final int segmentsCount;
  final Color filledColor;
  final Color? emptyColor;
  final double segmentSpacing;
  final double segmentHeight;
  final IconData icon;

  const SpecBarWidget({
    Key? key,
    required this.value,
    this.segmentsCount = 10,
    required this.filledColor,
    this.emptyColor,
    this.segmentSpacing = 4,
    this.segmentHeight = 10,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'привееееееееееет',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: segmentSpacing,
        children: [
          Icon(icon, color: filledColor, size: 20),
          ...List.generate(segmentsCount, (index) {
            final isFilled = index < value;
            return Expanded(
              child: Container(
                height: segmentHeight,
                decoration: ShapeDecoration(
                  color: isFilled ? filledColor : emptyColor ?? context.theme.colors.surfaceContainer,
                  shape: const StadiumBorder(),
                ),
              ),
            );
          }),
          SizedBox(
            width: 18,
            child: Center(child: Text('$value', style: context.theme.text.titleMedium?.copyWith(height: 1))),
          ),
        ],
      ),
    );
  }
}
