import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff49672d),
      surfaceTint: Color(0xff49672d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffcaeea6),
      onPrimaryContainer: Color(0xff0d2000),
      secondary: Color(0xff57624a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdbe7c9),
      onSecondaryContainer: Color(0xff151e0c),
      tertiary: Color(0xff386664),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbbece9),
      onTertiaryContainer: Color(0xff00201f),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff1a1d16),
      onSurfaceVariant: Color(0xff44483e),
      outline: Color(0xff74796d),
      outlineVariant: Color(0xffc4c8ba),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inversePrimary: Color(0xffafd18c),
      primaryFixed: Color(0xffcaeea6),
      onPrimaryFixed: Color(0xff0d2000),
      primaryFixedDim: Color(0xffafd18c),
      onPrimaryFixedVariant: Color(0xff324e18),
      secondaryFixed: Color(0xffdbe7c9),
      onSecondaryFixed: Color(0xff151e0c),
      secondaryFixedDim: Color(0xffbfcbae),
      onSecondaryFixedVariant: Color(0xff3f4a34),
      tertiaryFixed: Color(0xffbbece9),
      onTertiaryFixed: Color(0xff00201f),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff1e4e4c),
      surfaceDim: Color(0xffd9dbd0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f5e9),
      surfaceContainer: Color(0xffedefe4),
      surfaceContainerHigh: Color(0xffe8e9de),
      surfaceContainerHighest: Color(0xffe2e3d9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2f4a14),
      surfaceTint: Color(0xff49672d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5f7d42),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3b4630),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d785f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a4a48),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7c7a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff1a1d16),
      onSurfaceVariant: Color(0xff40443a),
      outline: Color(0xff5c6155),
      outlineVariant: Color(0xff787c70),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inversePrimary: Color(0xffafd18c),
      primaryFixed: Color(0xff5f7d42),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff47642b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6d785f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff546048),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7c7a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff366362),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9dbd0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f5e9),
      surfaceContainer: Color(0xffedefe4),
      surfaceContainerHigh: Color(0xffe8e9de),
      surfaceContainerHighest: Color(0xffe2e3d9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff122700),
      surfaceTint: Color(0xff49672d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2f4a14),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1b2512),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3b4630),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002726),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a4a48),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff21251c),
      outline: Color(0xff40443a),
      outlineVariant: Color(0xff40443a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inversePrimary: Color(0xffd4f7af),
      primaryFixed: Color(0xff2f4a14),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff193301),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3b4630),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff26301c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1a4a48),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003332),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9dbd0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f5e9),
      surfaceContainer: Color(0xffedefe4),
      surfaceContainerHigh: Color(0xffe8e9de),
      surfaceContainerHighest: Color(0xffe2e3d9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffafd18c),
      surfaceTint: Color(0xffafd18c),
      onPrimary: Color(0xff1d3703),
      primaryContainer: Color(0xff324e18),
      onPrimaryContainer: Color(0xffcaeea6),
      secondary: Color(0xffbfcbae),
      onSecondary: Color(0xff29341f),
      secondaryContainer: Color(0xff3f4a34),
      onSecondaryContainer: Color(0xffdbe7c9),
      tertiary: Color(0xffa0cfcd),
      onTertiary: Color(0xff003736),
      tertiaryContainer: Color(0xff1e4e4c),
      onTertiaryContainer: Color(0xffbbece9),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff11140e),
      onSurface: Color(0xffe2e3d9),
      onSurfaceVariant: Color(0xffc4c8ba),
      outline: Color(0xff8e9286),
      outlineVariant: Color(0xff44483e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d9),
      inversePrimary: Color(0xff49672d),
      primaryFixed: Color(0xffcaeea6),
      onPrimaryFixed: Color(0xff0d2000),
      primaryFixedDim: Color(0xffafd18c),
      onPrimaryFixedVariant: Color(0xff324e18),
      secondaryFixed: Color(0xffdbe7c9),
      onSecondaryFixed: Color(0xff151e0c),
      secondaryFixedDim: Color(0xffbfcbae),
      onSecondaryFixedVariant: Color(0xff3f4a34),
      tertiaryFixed: Color(0xffbbece9),
      onTertiaryFixed: Color(0xff00201f),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff1e4e4c),
      surfaceDim: Color(0xff11140e),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f09),
      surfaceContainerLow: Color(0xff1a1d16),
      surfaceContainer: Color(0xff1e211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb3d690),
      surfaceTint: Color(0xffafd18c),
      onPrimary: Color(0xff0a1a00),
      primaryContainer: Color(0xff7a9a5b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc3cfb2),
      onSecondary: Color(0xff101907),
      secondaryContainer: Color(0xff89957a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa4d4d1),
      onTertiary: Color(0xff001a19),
      tertiaryContainer: Color(0xff6b9997),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff11140e),
      onSurface: Color(0xfffafcf0),
      onSurfaceVariant: Color(0xffc8ccbe),
      outline: Color(0xffa0a497),
      outlineVariant: Color(0xff808578),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d9),
      inversePrimary: Color(0xff344f19),
      primaryFixed: Color(0xffcaeea6),
      onPrimaryFixed: Color(0xff071500),
      primaryFixedDim: Color(0xffafd18c),
      onPrimaryFixedVariant: Color(0xff223d08),
      secondaryFixed: Color(0xffdbe7c9),
      onSecondaryFixed: Color(0xff0b1404),
      secondaryFixedDim: Color(0xffbfcbae),
      onSecondaryFixedVariant: Color(0xff2f3924),
      tertiaryFixed: Color(0xffbbece9),
      onTertiaryFixed: Color(0xff001414),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff083d3b),
      surfaceDim: Color(0xff11140e),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f09),
      surfaceContainerLow: Color(0xff1a1d16),
      surfaceContainer: Color(0xff1e211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff3ffe1),
      surfaceTint: Color(0xffafd18c),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb3d690),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff3ffe1),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc3cfb2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffeafffd),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa4d4d1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff11140e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff9fced),
      outline: Color(0xffc8ccbe),
      outlineVariant: Color(0xffc8ccbe),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d9),
      inversePrimary: Color(0xff173000),
      primaryFixed: Color(0xffcff2aa),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb3d690),
      onPrimaryFixedVariant: Color(0xff0a1a00),
      secondaryFixed: Color(0xffdfebcd),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc3cfb2),
      onSecondaryFixedVariant: Color(0xff101907),
      tertiaryFixed: Color(0xffc0f0ed),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa4d4d1),
      onTertiaryFixedVariant: Color(0xff001a19),
      surfaceDim: Color(0xff11140e),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f09),
      surfaceContainerLow: Color(0xff1a1d16),
      surfaceContainer: Color(0xff1e211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
