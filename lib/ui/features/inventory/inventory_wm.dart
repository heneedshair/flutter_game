import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/data/models/local/inventory_item/inventory_item.dart';
import 'package:flutter_game/ui/features/inventory/inventory_model.dart';
import 'package:flutter_game/ui/features/inventory/inventory_widget.dart';
import 'package:flutter_game/ui/features/inventory/item_bottom_sheet/inventory_item_bottom_sheet.dart';

abstract interface class IInventoryWidgetModel implements IWidgetModel {
  EntityValueListenable<List<InventoryItem>> get itemsListenable;

  void onItemTap(int index);
}

InventoryWidgetModel defaultInventoryWidgetModelFactory(BuildContext context) {
  return InventoryWidgetModel(InventoryModel());
}

class InventoryWidgetModel extends WidgetModel<InventoryWidget, IInventoryModel> implements IInventoryWidgetModel {
  InventoryWidgetModel(super.model);
  @override
  Future<void> initWidgetModel() async {
    await _initItems();

    super.initWidgetModel();
  }

  Future<void> _initItems() async {
    _itemsEntity.loading();

    try {
      await Future.delayed(const Duration(microseconds: 200));

      final items = List.generate(15, (index) {
        if (index % 9 == 0) {
          return Chest(
            id: index,
            name: 'Сундук $index',
            rare: ((index ~/ 3) % 5),
            price: index * 100,
            imageUrl: '',
            minRare: 0,
            maxRare: 5,
          );
        } else {
          return Character(
            id: index,
            name: index % 3 != 0 ? 'Крутой Котярааа' : 'Дефолт',
            isArtificialSpecs: index % 3 == 0,
            rare: ((index ~/ 3) % 5),
            imageUrl: 'assets/cat.png',
            leftRatings: index * 2,
            price: index * 10,
            spec1: 1,
            spec2: 6,
            spec3: 5,
            spec4: 3,
            spec5: 8,
          );
        }
      });

      _itemsEntity.content(items);
    } catch (e) {
      _itemsEntity.error();
      debugPrint(e.toString());
    }
  }

  final _itemsEntity = EntityStateNotifier<List<InventoryItem>>();

  @override
  EntityValueListenable<List<InventoryItem>> get itemsListenable => _itemsEntity;

  @override
  void onItemTap(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => InventoryItemBottomSheet(item: _itemsEntity.value.data![index]),
    );
  }
}
