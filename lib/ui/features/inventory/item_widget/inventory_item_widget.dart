import 'package:flutter/material.dart';
import 'package:flutter_game/common/ui/widgets/minimalistic_specs_widget.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/features/inventory/item_widget/widgets/bar_info_widget.dart';
import 'package:flutter_game/ui/features/inventory/item_widget/widgets/rating_indicator.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemWidget extends StatelessWidget {
  const InventoryItemWidget({super.key, required this.item, required this.onItemTap});

  final InventoryItem item;
  final Function(Color newColor) onItemTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

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
            (character) =>
                character.isArtificialSpecs
                    ? null
                    : RatingIndicator(
                      backgroundColor: trueExtraColor,
                      foregroundColor: colors.surface,
                      value: character.leftRatings,
                    ),
        chest: (_) => null,
      ),
      barInfoWidget: item.map(
        character:
            (character) => BarInfoWidget(
              label: 'lvl',
              //TODO заменить на lvl
              value: character.price,
              extraColor: character.isArtificialSpecs ? colors.primaryContainer : extraColor,
            ),
        chest: (chest) => BarInfoWidget(label: '\$', value: chest.price, extraColor: extraColor),
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
