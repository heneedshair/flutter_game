import 'package:auto_route/auto_route.dart';
import 'package:flutter_game/ui/features/navigation/navigation_widget.dart';
import 'package:flutter_game/ui/features/welcome/welcome_widget.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Widget,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    CustomRoute(
      page: NavigationRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: const Duration(milliseconds: 300),
    ),
  ];
}
