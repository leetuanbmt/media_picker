part of config;

class AppTheme {
  AppTheme._();

  static Color primaryColor = AppColors.defaultColor;
  static const background = Colors.white;
  static const surface = Color(0xffF5F8FA);
  static const title = Color(0xff6d7175);
  static const dividerColor = Color(0xffE5E5E5);
  static const defaultGrey = Color(0xffBDBDBD);
  static const greyText = Color(0xff565656);

  static ThemeData get appTheme {
    ColorScheme colorScheme = ColorScheme.light(
      primary: primaryColor,
      surface: surface,
    );

    final themeData = ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: primaryColor,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: Colors.transparent,
        indicatorColor: AppTheme.primaryColor,
        labelColor: AppTheme.primaryColor,
        unselectedLabelColor: Colors.grey.shade600,
        indicator: const BoxDecoration(),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
    final TextTheme textTheme = themeData.textTheme;
    return themeData.copyWith(
      textTheme: textTheme.copyWith(
        labelLarge: textTheme.labelLarge!.copyWith(
          fontSize: 14.sp,
          letterSpacing: 0.04.sp,
        ),
        bodyLarge: textTheme.bodyLarge!.copyWith(
          fontSize: 14.sp,
          letterSpacing: 0.04.sp,
        ),
        bodyMedium: textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
          letterSpacing: 0.04.sp,
        ),
        titleMedium: textTheme.titleMedium!.copyWith(
          fontSize: 16.sp,
          letterSpacing: 0.04.sp,
        ),
        titleSmall: textTheme.titleSmall!.copyWith(
          fontSize: 16.sp,
          letterSpacing: 0.04.sp,
        ),
        bodySmall: textTheme.bodySmall!.copyWith(
          fontSize: 12.sp,
          letterSpacing: 0.04.sp,
        ),
        labelSmall: textTheme.labelSmall!.copyWith(
          fontSize: 10.sp,
          letterSpacing: 0.04.sp,
        ),
        titleLarge: textTheme.titleLarge!.copyWith(
          fontSize: 20.sp,
          letterSpacing: 0.04.sp,
        ),
      ),
    );
  }
}
