import 'package:flutter/material.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemWidget extends StatelessWidget {
  const InventoryItemWidget({super.key, required this.item, required this.onItemTap});

  final InventoryItem item;
  final Function(Color newColor) onItemTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return _CardWidget(
      name: item.name,
      textColor: item.map(character: (_) => colors.primary, chest: (_) => item.rare.getColorByRarity(colors)),
      borderColor: item.map(
        character:
            (character) =>
                character.isArtificialSpecs
                    ? colors.surfaceContainer
                    : character.rare.getColorByRarity(colors).withAlpha(200),
        chest: (_) => item.rare.getColorByRarity(colors).withAlpha(200),
      ),
      imageUrl: item.imageUrl,
      onItemTap: onItemTap,
      price: item.price,
      onImageWidget: item.map(
        character:
            (character) => Stack(
              children: [
                if (!character.isArtificialSpecs)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: character.rare.getColorByRarity(colors),
                    ),
                    child: Text(
                      '${character.leftRatings}',
                      style: context.theme.text.labelMedium?.copyWith(color: colors.onPrimary, height: 1),
                    ),
                  ),
              ],
            ),
        chest: (_) => null,
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.name,
    required this.textColor,
    required this.borderColor,
    required this.imageUrl,
    required this.onItemTap,
    required this.price,
    this.onImageWidget,
  });

  final String name;
  final int price;
  final String imageUrl;
  final Color textColor;
  final Color borderColor;
  final Function(Color newColor) onItemTap;
  final Widget? onImageWidget;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    return GestureDetector(
      onTap: () => onItemTap(borderColor),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(width: 2.3, color: borderColor),
          borderRadius: BorderRadius.circular(18),
          color: colors.surfaceContainerHighest,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.hardEdge,
                    //TODO заменить на network
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(child: Icon(Icons.broken_image_outlined, color: textColor)),
                      // loadingBuilder: (_, __, ___) => Center(child: Icon(Icons.photo, color: textColor)),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.text.titleSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.lerp(FontWeight.w700, FontWeight.w800, 0.25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$', style: textStyles.titleSmall),
                      Text('$price', maxLines: 1, style: textStyles.titleSmall),
                    ],
                  ),
                ),
              ],
            ),
            if (onImageWidget != null) onImageWidget!,
          ],
        ),
      ),
    );
  }
}
