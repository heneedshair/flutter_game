import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_game/common/ui/widgets/app_text_field.dart';
import 'package:flutter_game/common/ui/widgets/buttons.dart';
import 'package:flutter_game/ui/features/welcome/welcome_wm.dart';
import 'package:flutter_game/ui/theme/theme.dart';

@RoutePage()
class WelcomeWidget extends ElementaryWidget<WelcomeWidgetModel> {
  const WelcomeWidget({super.key}) : super(defaultWelcomeWidgetModelFactory);

  @override
  Widget build(IWelcomeWidgetModel wm) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Привет!', style: context.theme.textTheme.displayMedium),
                    const SizedBox(height: 8),
                    Text('Начнем с тебя?', style: context.theme.textTheme.headlineMedium),
                    const SizedBox(height: 64),
                    const AppTextField(labelText: 'Как тебя зовут?'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button.filledSecondary(
                          onTap: () => wm.onContinueTap(),
                          text: 'Продолжить',
                          suffixIcon: Icons.keyboard_arrow_right_rounded,
                          spacing: 4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 96),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
