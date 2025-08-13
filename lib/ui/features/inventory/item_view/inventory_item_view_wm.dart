import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/ui/features/inventory/item_view/inventory_item_view_model.dart';
import 'package:flutter_game/ui/features/inventory/item_view/inventory_item_view_widget.dart';

abstract interface class IInventoryItemViewWidgetModel implements IWidgetModel {
  BuildContext get context;

  PageController get pageController;
}

InventoryItemViewWidgetModel defaultInventoryItemViewWidgetModelFactory(BuildContext context) {
  return InventoryItemViewWidgetModel(InventoryItemViewModel());
}

class InventoryItemViewWidgetModel extends WidgetModel<InventoryItemViewWidget, IInventoryItemViewModel>
    implements IInventoryItemViewWidgetModel {
  InventoryItemViewWidgetModel(super.model);
  @override
  void initWidgetModel() {
    _pageController = PageController(initialPage: widget.selectedItemIndex, viewportFraction: 0.9);

    super.initWidgetModel();
  }

  late PageController _pageController;

  @override
  PageController get pageController => _pageController;
}
