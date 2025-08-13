import 'package:flutter/material.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemWidget extends StatelessWidget {
  const InventoryItemWidget({super.key, required this.item, required this.onItemTap});

  final InventoryItem item;
  final VoidCallback onItemTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    //TODO спустить МАП вниз по дереву
    return item.map(
      characher:
          (characher) => _CardWidget(
            onItemTap: () => onItemTap(),
            name: characher.name,
            price: characher.price,
            imageUrl: characher.imageUrl,
            textColor: colors.primary,
            borderColor:
                characher.isArtificialSpecs
                    ? colors.surfaceContainer
                    : characher.rare.getColorByRarity(colors).withAlpha(200),
            //TODO переделать для больших чисел
            onImageChild: Stack(
              children: [
                if (!characher.isArtificialSpecs)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: characher.rare.getColorByRarity(colors),
                    ),
                    child: Text(
                      '${characher.leftRatings}',
                      style: context.theme.text.labelMedium?.copyWith(color: colors.onPrimary, height: 1),
                    ),
                  ),
              ],
            ),
          ),
      chest:
          (chest) => _CardWidget(
            onItemTap: () => onItemTap(),
            name: item.name,
            price: chest.price,
            imageUrl: item.imageUrl,
            textColor: chest.rare.getColorByRarity(colors),
            borderColor: chest.rare.getColorByRarity(colors).withAlpha(200),
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
    this.onImageChild,
  });

  final String name;
  final int price;
  final String imageUrl;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onItemTap;
  final Widget? onImageChild;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    return GestureDetector(
      onTap: () => onItemTap(),
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
            if (onImageChild != null) onImageChild!,
          ],
        ),
      ),
    );
  }
}
