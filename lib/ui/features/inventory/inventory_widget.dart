import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/ui/features/inventory/inventory_wm.dart';
import 'package:flutter_game/ui/features/inventory/widgets/inventory_item_widget.dart';
import 'package:flutter_game/ui/theme/theme.dart';

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
                    //TODO брать от пользователя
                    itemCount: 24,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 158.6,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder:
                        (_, index) =>
                            index < items.length
                                ? InventoryItemWidget(item: items[index])
                                : Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.3, color: context.theme.colors.surfaceContainer),
                                    borderRadius: BorderRadius.circular(18),
                                    color: context.theme.colors.surfaceContainerHighest,
                                  ),
                                ),
                  ),
    );
  }
}
