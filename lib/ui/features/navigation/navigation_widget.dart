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
      child: ValueListenableBuilder(
        valueListenable: wm.appBarColorNotifier,
        builder:
            (context, appBarColor, _) => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(62),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  color: appBarColor,
                  child: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 62,
                    backgroundColor: Colors.transparent, // Прозрачный, чтобы был цвет AnimatedContainer
                    foregroundColor: context.theme.colors.onSecondary,
                    title: UserTabWidget(onUserTap: () => wm.onUserTap()),
                    actions: [
                      IconButton(
                        onPressed: () => wm.onNotificationsTap(),
                        icon: const Icon(Icons.notifications_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () => wm.onSettingsTap(),
                          icon: const Icon(Icons.settings_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: EntityStateNotifierBuilder<int?>(
                listenableEntityState: wm.currentTabListenable,
                builder:
                    (_, index) => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder: (child, animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(1.0, 0),
                          end: Offset.zero,
                        ).animate(animation);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                      child: switch (index) {
                        0 => const Center(key: ValueKey(0)),
                        1 => InventoryWidget(key: const ValueKey(1), changeAppBarColor: wm.changeAppBarColor),
                        null => const SizedBox.shrink(key: ValueKey('empty')),
                        int() => const SizedBox.shrink(key: ValueKey('empty')),
                      },
                    ),
              ),
              bottomNavigationBar: EntityStateNotifierBuilder(
                listenableEntityState: wm.currentTabListenable,
                builder:
                    (context, index) =>
                        index == null
                            ? const SizedBox.shrink()
                            : BottomNavigationBar(
                              currentIndex: index,
                              selectedItemColor: appBarColor,
                              type: BottomNavigationBarType.fixed,
                              onTap: (index) => wm.onNavigationTap(index),
                              items: const [
                                BottomNavigationBarItem(label: 'Лента', icon: Icon(Icons.star_rounded)),
                                BottomNavigationBarItem(label: 'Инвентарь', icon: Icon(Icons.inventory_2_rounded)),
                              ],
                            ),
              ),
            ),
      ),
    );
  }
}
