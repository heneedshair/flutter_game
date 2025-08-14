import 'package:flutter/material.dart';

class MinimalisticSpecsBar extends StatelessWidget {
  const MinimalisticSpecsBar({
    super.key,
    required this.value,
    required this.filledColor,
    required this.emptyColor,
    this.height = 4,
  });

  final int value;
  final Color filledColor;
  final Color emptyColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final value = this.value / 10;

    return SizedBox(
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: Container(
          height: height,
          color: emptyColor,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(color: filledColor),
          ),
        ),
      ),
    );
  }
}
