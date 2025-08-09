import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/ui/features/inventory/inventory_widget.dart';
import 'package:flutter_game/ui/features/navigation/navigation_wm.dart';
import 'package:flutter_game/ui/features/navigation/widgets/user_tab_widget.dart';
import 'package:flutter_game/ui/theme/theme.dart';

@RoutePage()
class NavigationWidget extends ElementaryWidget<NavigationWidgetModel> {
  const NavigationWidget({super.key}) : super(defaultNavigationWidgetModelFactory);

  @override
  Widget build(INavigationWidgetModel wm) {
    return PopScope(
      canPop: false,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 62,
              backgroundColor: context.theme.colors.secondary,
              foregroundColor: context.theme.colors.onSecondary,
              title: UserTabWidget(onUserTap: () => wm.onUserTap()),
            ),
            body: EntityStateNotifierBuilder(
              listenableEntityState: wm.currentTabListenable,
              builder:
                  (_, index) => switch (index) {
                    0 => const Center(),
                    1 => const InventoryWidget(),
                    null => const SizedBox.shrink(),
                    int() => const SizedBox.shrink(),
                  },
            ),
            bottomNavigationBar: EntityStateNotifierBuilder(
              listenableEntityState: wm.currentTabListenable,
              builder:
                  (context, index) =>
                      index == null
                          ? const SizedBox.shrink()
                          : BottomNavigationBar(
                            currentIndex: index,
                            type: BottomNavigationBarType.fixed,
                            onTap: (index) => wm.onNavigationTap(index),
                            items: const [
                              BottomNavigationBarItem(label: 'Лента', icon: Icon(Icons.star_rounded)),
                              BottomNavigationBarItem(label: 'Инвентарь', icon: Icon(Icons.inventory_2_rounded)),
                            ],
                          ),
            ),
          );
        },
      ),
    );
  }
}
