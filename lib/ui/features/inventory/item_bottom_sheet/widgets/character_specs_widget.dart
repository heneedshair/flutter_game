import 'package:flutter/material.dart';
import 'package:flutter_game/common/ui/widgets/spec_bar_widget.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class CharacterSpecsWidget extends StatelessWidget {
  const CharacterSpecsWidget({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(left: 4), child: Text('Характеристики:', style: textStyles.titleMedium)),
        const SizedBox(height: 3),
        SpecBarWidget(value: character.spec1, icon: Icons.favorite_rounded, filledColor: Colors.red),
        SpecBarWidget(value: character.spec2, filledColor: Colors.blue, icon: Icons.lightbulb_rounded),
        SpecBarWidget(value: character.spec3, filledColor: Colors.orange, icon: Icons.warning_rounded),
        SpecBarWidget(value: character.spec4, filledColor: Colors.green, icon: Icons.mood_rounded),
        SpecBarWidget(value: character.spec5, filledColor: Colors.purple, icon: Icons.campaign_rounded),
        const SizedBox(height: 10),
      ],
    );
  }
}
