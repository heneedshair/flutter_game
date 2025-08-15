import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/ui/features/inventory/inventory_wm.dart';
import 'package:flutter_game/ui/features/inventory/item_widget/inventory_item_widget.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class InventoryWidget extends ElementaryWidget<InventoryWidgetModel> {
  const InventoryWidget({super.key, required this.changeAppBarColor}) : super(defaultInventoryWidgetModelFactory);

  final Function(Color newColor) changeAppBarColor;

  @override
  Widget build(IInventoryWidgetModel wm) {
    return EntityStateNotifierBuilder(
      loadingBuilder: (_, __) => const Center(child: CircularProgressIndicator()),
      listenableEntityState: wm.itemsListenable,
      builder:
          (context, items) =>
              items == null
                  ? const SizedBox.shrink()
                  : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    //TODO брать от пользователя
                    itemCount: 24,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.72,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder:
                        (_, index) =>
                            index < items.length
                                ? InventoryItemWidget(
                                  onItemTap: (newColor) => wm.onItemTap(index, newColor),
                                  item: items[index],
                                )
                                : Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 4, color: context.theme.colors.surfaceContainer),
                                    borderRadius: BorderRadius.circular(18),
                                    color: context.theme.colors.surfaceContainerHighest,
                                  ),
                                ),
                  ),
    );
  }
}
