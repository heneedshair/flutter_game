import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_game/ui/features/navigation/navigation_model.dart';
import 'package:flutter_game/ui/features/navigation/navigation_widget.dart';

abstract interface class INavigationWidgetModel implements IWidgetModel {
  EntityValueListenable<int> get currentTabListenable;

  void onNavigationTap(int index);

  void onUserTap();
}

NavigationWidgetModel defaultNavigationWidgetModelFactory(BuildContext context) {
  return NavigationWidgetModel(NavigationModel());
}

class NavigationWidgetModel extends WidgetModel<NavigationWidget, INavigationModel> implements INavigationWidgetModel {
  NavigationWidgetModel(super.model);
  @override
  void initWidgetModel() {
    _currentTabEntity.content(1);

    super.initWidgetModel();
  }

  final _currentTabEntity = EntityStateNotifier<int>();

  @override
  EntityValueListenable<int> get currentTabListenable => _currentTabEntity;

  @override
  void onNavigationTap(int index) => _currentTabEntity.content(index);

  @override
  void onUserTap() {}
}
