import 'package:flutter/material.dart';
import 'package:flutter_game/common/ui/widgets/minimalistic_specs_widget.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemWidget extends StatelessWidget {
  const InventoryItemWidget({super.key, required this.item, required this.onItemTap});

  final InventoryItem item;
  final Function(Color newColor) onItemTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    final trueExtraColor = item.rare.getColorByRarity(colors);
    final extraColor = trueExtraColor.withAlpha(200);

    return _CardWidget(
      name: item.name,
      textColor: item.map(character: (_) => colors.primary, chest: (_) => extraColor),
      barColor: item.map(
        character: (character) => character.isArtificialSpecs ? colors.primaryContainer : extraColor,
        chest: (_) => extraColor,
      ),
      extraColor: item.map(
        character: (character) => character.isArtificialSpecs ? colors.surfaceContainer : extraColor,
        chest: (_) => extraColor,
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: trueExtraColor),
                    child: Text(
                      '${character.leftRatings}',
                      style: context.theme.text.labelMedium?.copyWith(
                        color: colors.onPrimary,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
        chest: (_) => null,
      ),
      barInfoWidget: item.map(
        character: (character) {
          final localExtraColor = character.isArtificialSpecs ? colors.primaryContainer : extraColor;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'lvl',
                style: textStyles.titleSmall?.copyWith(
                  color: localExtraColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  height: 1,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                //TODO заменить на уровень
                '${character.price}',
                maxLines: 1,
                style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w600, fontSize: 13, height: 1),
              ),
            ],
          );
        },
        chest: (chest) => null,
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.name,
    required this.textColor,
    required this.extraColor,
    required this.imageUrl,
    required this.onItemTap,
    required this.price,
    this.onImageWidget,
    this.barInfoWidget,
    required this.barColor,
  });

  final String name;
  final int price;
  final String imageUrl;
  final Color textColor;
  final Color barColor;
  final Color extraColor;
  final Function(Color newColor) onItemTap;
  final Widget? onImageWidget;
  final Widget? barInfoWidget;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    return GestureDetector(
      onTap: () => onItemTap(extraColor),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: extraColor),
          borderRadius: BorderRadius.circular(18),
          color: colors.surfaceContainerHighest,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// [Image]
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      clipBehavior: Clip.hardEdge,
                      //TODO заменить на network
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Center(child: Icon(Icons.broken_image_outlined, color: textColor)),
                        // loadingBuilder: (_, __, ___) => Center(child: Icon(Icons.photo, color: textColor)),
                      ),
                    ),
                    if (onImageWidget != null) onImageWidget!,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),

            /// [Name]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyles.titleSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.lerp(FontWeight.w700, FontWeight.w800, 0.25),
                ),
              ),
            ),
            const SizedBox(height: 2),

            /// [Progress Bar]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MinimalisticSpecsBar(value: 7, filledColor: barColor, emptyColor: colors.surfaceContainer),
            ),
            const SizedBox(height: 3),

            /// [Bar Info]
            if (barInfoWidget != null) barInfoWidget!,
          ],
        ),
      ),
    );
  }
}
