part of '../theme.dart';

class AppColors {
  const AppColors._({
    required this.primary,
    required this.primaryContainer,
    required this.primaryFixedDim,
    required this.onPrimary,
    required this.secondary,
    required this.secondaryContainer,
    required this.secondaryFixedDim,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.surface,
    required this.surfaceContainer,
    required this.surfaceContainerHighest,
    required this.surfaceContainerLow,
    required this.onSurface,
  });

  factory AppColors.light() => const AppColors._(
    primary: Color.fromARGB(255, 179, 134, 89),
    primaryContainer: Color.fromARGB(255, 212, 163, 115),
    primaryFixedDim: Color.fromARGB(255, 125, 81, 39),
    onPrimary: Color.fromARGB(255, 250, 237, 205),
    secondary: Color.fromARGB(255, 172, 189, 116),
    secondaryContainer: Color.fromARGB(255, 204, 213, 174),
    secondaryFixedDim: Color.fromARGB(255, 108, 118, 75),
    onSecondary: Color.fromARGB(255, 250, 237, 205),
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Color.fromARGB(255, 254, 250, 226),
    surfaceContainer: Color.fromARGB(255, 250, 237, 205),
    surfaceContainerHighest: Colors.white,
    surfaceContainerLow: Colors.black,
    onSurface: Color.fromARGB(255, 179, 134, 89),
  );

  factory AppColors.dark() => AppColors.light(); //TODO темную тему

  final Color primary;
  final Color primaryContainer;
  final Color primaryFixedDim;
  final Color onPrimary;
  final Color secondary;
  final Color secondaryContainer;
  final Color secondaryFixedDim;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color surface;
  final Color surfaceContainer;
  final Color surfaceContainerHighest;
  final Color surfaceContainerLow;
  final Color onSurface;
}
