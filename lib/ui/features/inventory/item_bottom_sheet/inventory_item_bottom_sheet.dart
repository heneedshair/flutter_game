import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemBottomSheet extends StatelessWidget {
  const InventoryItemBottomSheet({super.key, required this.item});

  final InventoryItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actionsPadding: const EdgeInsets.only(right: 8),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.close_rounded))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Center(
            child: _CardWidget(
              name: item.name,
              price: item.price,
              imageUrl: item.imageUrl,
              headerColor: item.map(
                characher: (_) => colors.onSurface,
                chest: (chest) => chest.rare.getColorByRarity(colors),
              ),
              borderColor: item.map(
                characher:
                    (characher) =>
                        characher.isArtificialSpecs ? colors.surfaceContainer : characher.rare.getColorByRarity(colors),
                chest: (chest) => chest.rare.getColorByRarity(colors),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.headerColor,
    required this.borderColor,
    this.onImageChild,
  });

  final String name;
  final int price;
  final String imageUrl;
  final Color headerColor;
  final Color borderColor;
  final Widget? onImageChild;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 4),
        borderRadius: BorderRadius.circular(44),
        color: colors.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(aspectRatio: 1, child: Image.asset('assets/cat.png', fit: BoxFit.cover)),
          ),
          Text(name, style: textStyles.headlineMedium?.copyWith(color: headerColor)),
        ],
      ),
    );
  }
}
