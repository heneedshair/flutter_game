import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/ui/features/inventory/inventory_wm.dart';
import 'package:flutter_game/ui/features/inventory/widgets/inventory_item_widget.dart';

class InventoryWidget extends ElementaryWidget<InventoryWidgetModel> {
  const InventoryWidget({super.key}) : super(defaultInventoryWidgetModelFactory);

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
                    itemCount: items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 159,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) => InventoryItemWidget(item: items[index]),
                  ),
    );
  }
}
