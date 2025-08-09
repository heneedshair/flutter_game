import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/common/router/app_router.dart';
import 'package:flutter_game/ui/features/welcome/welcome_model.dart';
import 'package:flutter_game/ui/features/welcome/welcome_widget.dart';

abstract interface class IWelcomeWidgetModel implements IWidgetModel {
  void onContinueTap();
}

WelcomeWidgetModel defaultWelcomeWidgetModelFactory(BuildContext context) {
  return WelcomeWidgetModel(WelcomeModel());
}

class WelcomeWidgetModel extends WidgetModel<WelcomeWidget, IWelcomeModel> implements IWelcomeWidgetModel {
  WelcomeWidgetModel(super.model);
  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void onContinueTap() {
    AutoRouter.of(context).push(const NavigationRoute());
  }
}
