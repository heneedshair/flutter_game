import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, this.labelText});

  final String? labelText;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textStyle = context.theme.text;
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textStyle.titleMedium?.copyWith(color: colors.primaryContainer),
        floatingLabelStyle: textStyle.titleMedium?.copyWith(color: colors.primary),
        focusColor: colors.secondary,
        prefixIconColor: colors.onSurface,
        suffixIconColor: colors.onSurface,
        filled: true,
        fillColor: colors.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: colors.surfaceContainer, width: 2.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: colors.primaryContainer, width: 2.5),
        ),
      ),
    );
  }
}
