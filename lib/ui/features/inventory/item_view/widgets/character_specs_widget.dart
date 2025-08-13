import 'package:flutter/material.dart';
import 'package:flutter_game/common/ui/widgets/spec_bar_widget.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';

class CharacterSpecsWidget extends StatelessWidget {
  const CharacterSpecsWidget({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpecBarWidget(value: character.spec1, icon: Icons.favorite_rounded, filledColor: Colors.red),
          SpecBarWidget(value: character.spec2, filledColor: Colors.blue, icon: Icons.lightbulb_rounded),
          SpecBarWidget(value: character.spec3, filledColor: Colors.orange, icon: Icons.warning_rounded),
          SpecBarWidget(value: character.spec4, filledColor: Colors.green, icon: Icons.mood_rounded),
          SpecBarWidget(value: character.spec5, filledColor: Colors.purple, icon: Icons.auto_awesome_rounded),
        ],
      ),
    );
  }
}
