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
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        EntityStateNotifierBuilder(
          loadingBuilder: (_, __) => const Center(child: CircularProgressIndicator()),
          listenableEntityState: wm.itemsListenable,
          builder:
              (context, items) =>
                  items == null
                      ? const SizedBox.shrink()
                      : Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: List.generate(
                          //TODO брать от пользователя
                          24,
                          (index) => SizedBox(
                            //! ГОВНО
                            width: MediaQuery.of(context).size.width / 3 - 14.7,
                            child:
                                index < items.length
                                    ? InventoryItemWidget(
                                      onItemTap: (newColor) => wm.onItemTap(index, newColor),
                                      item: items[index],
                                    )
                                    : Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2.3, color: context.theme.colors.surfaceContainer),
                                        borderRadius: BorderRadius.circular(18),
                                        color: context.theme.colors.surfaceContainerHighest,
                                      ),
                                    ),
                          ),
                        ),
                      ),
        ),
      ],
    );
  }
}
