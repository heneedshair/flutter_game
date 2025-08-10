import 'package:flutter/material.dart';
import 'package:flutter_game/common/router/app_router.dart';
import 'package:flutter_game/ui/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(theme: AppThemeData.light, routerConfig: _appRouter.config());
  }
}
