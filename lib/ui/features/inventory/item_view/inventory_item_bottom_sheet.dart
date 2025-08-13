import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/features/inventory/item_view/widgets/character_specs_widget.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemView extends StatelessWidget {
  const InventoryItemView({super.key, required this.items, required this.selectedItemIndex});

  final List<InventoryItem> items;
  final int selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actionsPadding: const EdgeInsets.only(right: 12, top: 4),
        actions: [
          CircleAvatar(
            backgroundColor: colors.surface.withAlpha(100),
            //TODO убрать функцию в wm
            child: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close_rounded)),
          ),
        ],
      ),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: PageView.builder(
          itemCount: items.length,
          controller: PageController(initialPage: selectedItemIndex),
          itemBuilder: (context, index) {
            final item = items[index];

            /// [ItevWidgetFullWidget]
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Center(
                child: _CardWidget(
                  name: item.name,
                  isEditableName: item is Character,
                  price: item.price,
                  imageUrl: item.imageUrl,
                  headerColor: item.map(
                    characher: (_) => colors.onSurface,
                    chest: (chest) => chest.rare.getColorByRarity(colors),
                  ),
                  borderColor: item.map(
                    characher:
                        (characher) =>
                            characher.isArtificialSpecs
                                ? colors.surfaceContainer
                                : characher.rare.getColorByRarity(colors),
                    chest: (chest) => chest.rare.getColorByRarity(colors),
                  ),
                  itemInfoWidget: item.map(
                    characher: (characher) => CharacterSpecsWidget(character: characher),
                    chest: (_) => null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.name,
    required this.isEditableName,
    required this.price,
    required this.imageUrl,
    required this.headerColor,
    required this.borderColor,
    this.onImageWidget,
    this.itemInfoWidget,
  });

  final String name;
  final bool isEditableName;
  final int price;
  final String imageUrl;
  final Color headerColor;
  final Color borderColor;
  final Widget? onImageWidget;
  final Widget? itemInfoWidget;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyles = context.theme.text;

    const padding = 20.0;
    const borderWidth = 4.0;
    const childBorderradius = 24.0;

    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(48),
        color: colors.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// [Image]
          ClipRRect(
            borderRadius: BorderRadius.circular(childBorderradius),
            child: AspectRatio(aspectRatio: 1, child: Image.asset('assets/cat.png', fit: BoxFit.cover)),
          ),

          /// [Name]
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              splashColor: colors.surfaceContainer,
              onTap: isEditableName ? () {} : null,
              child: Ink(
                padding: const EdgeInsets.symmetric(vertical: padding / 4, horizontal: padding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (isEditableName) Icon(Icons.edit_outlined, color: colors.primary),
                  ],
                ),
              ),
            ),
          ),

          /// [Item Info]
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: (padding - borderWidth) / 2,
              vertical: (padding - borderWidth) / 3,
            ),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(childBorderradius),
              color: colors.surfaceContainerHighest,
              border: Border.all(color: colors.surfaceContainer, width: borderWidth),
            ),
            child: itemInfoWidget,
          ),
        ],
      ),
    );
  }
}
