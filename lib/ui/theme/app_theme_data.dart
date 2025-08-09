part of 'theme.dart';

abstract final class AppThemeData {
  static get light => _getAppThemeData(AppColors.light(), Brightness.light);

  static get dark => _getAppThemeData(AppColors.dark(), Brightness.dark);

  static ThemeData _getAppThemeData(AppColors colors, Brightness brightness) => ThemeData(
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      primaryContainer: colors.primaryContainer,
      onPrimary: colors.surface,
      secondary: colors.secondary,
      secondaryFixedDim: colors.secondaryFixedDim,
      onSecondary: colors.surface,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      surfaceContainer: colors.surfaceContainer,
      surfaceContainerHighest: colors.surfaceContainerHighest,
      surfaceContainerLow: colors.surfaceContainerLow,
      onSurface: colors.primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
      selectedItemColor: colors.secondary,
      unselectedItemColor: colors.secondaryFixedDim,
      selectedLabelStyle: const TextStyle(fontSize: 14, height: 1),
      unselectedLabelStyle: const TextStyle(fontSize: 12, height: 1),
    ),
  );
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ColorExtension on ThemeData {
  ColorScheme get colors => colorScheme;

  TextTheme get text => textTheme;
}
