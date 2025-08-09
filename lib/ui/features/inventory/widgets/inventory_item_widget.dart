import 'package:flutter/material.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemWidget extends StatelessWidget {
  const InventoryItemWidget({super.key, required this.item});

  final InventoryItem item;

  Color colorByRarity(BuildContext context) => switch (item.rare) {
    0 => context.theme.colors.primaryContainer,
    1 => Colors.grey,
    2 => Colors.blueAccent,
    3 => Colors.lightGreen,
    4 => context.theme.colors.error,
    int() => throw Exception('invalid rare value: ${item.rare}'),
  };

  @override
  Widget build(BuildContext context) {
    return item.map(
      characher:
          (characher) => _CardWidget(
            onTap: () {},
            name: characher.name,
            price: characher.price,
            imageUrl: characher.imageUrl,
            // textColor: characher.isArtificialSpecs ? context.theme.colors.primaryContainer : colorByRarity(context),
            textColor: context.theme.colors.primary,
            borderColor:
                characher.isArtificialSpecs
                    ? context.theme.colors.surfaceContainer
                    : colorByRarity(context).withAlpha(200),
            //TODO переделать для больших чисел
            onImageChild: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.theme.colors.primary),
              child: Center(
                child: Text(
                  '${characher.leftRatings}',
                  style: context.theme.text.labelSmall?.copyWith(color: context.theme.colors.surfaceContainerHighest),
                ),
              ),
            ),
          ),
      chest:
          (chest) => _CardWidget(
            onTap: () {},
            name: item.name,
            price: chest.price,
            imageUrl: item.imageUrl,
            textColor: colorByRarity(context),
            borderColor: colorByRarity(context).withAlpha(200),
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
    required this.onTap,
    required this.price,
    this.onImageChild,
  });

  final String name;
  final int price;
  final String imageUrl;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;
  final Widget? onImageChild;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.theme.text.titleSmall;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(width: 2.3, color: borderColor),
          borderRadius: BorderRadius.circular(18),
          color: context.theme.colors.surfaceContainerHighest,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/cat.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(child: Icon(Icons.broken_image_outlined, color: textColor)),
                    // loadingBuilder: (_, __, ___) => Center(child: Icon(Icons.photo, color: textColor)),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.text.titleSmall?.copyWith(color: textColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('\$', style: labelStyle), Text('$price', maxLines: 1, style: labelStyle)],
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
