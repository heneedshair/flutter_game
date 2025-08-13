import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/features/inventory/item_view/inventory_item_view_wm.dart';
import 'package:flutter_game/ui/features/inventory/item_view/widgets/inventory_item_page.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryItemViewWidget extends ElementaryWidget<InventoryItemViewWidgetModel> {
  const InventoryItemViewWidget({
    super.key,
    required this.items,
    required this.selectedItemIndex,
    required this.onPageChanged,
  }) : super(defaultInventoryItemViewWidgetModelFactory);

  final List<InventoryItem> items;
  final int selectedItemIndex;
  final Function(Color newColor) onPageChanged;

  @override
  Widget build(IInventoryItemViewWidgetModel wm) {
    final context = wm.context;
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
          controller: wm.pageController,
          onPageChanged: (index) {
            final item = items[index];
            onPageChanged(
              item.map(
                character:
                    (characher) =>
                        characher.isArtificialSpecs ? colors.surfaceContainer : item.rare.getColorByRarity(colors),
                chest: (chest) => item.rare.getColorByRarity(colors),
              ),
            );
          },
          itemBuilder:
              (_, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InventoryItemPage(item: items[index]),
              ),
        ),
      ),
    );
  }
}
