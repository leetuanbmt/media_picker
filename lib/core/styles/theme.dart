part of config;

class AppTheme {
  AppTheme._();

  static Color primaryColor = defaultColor;

  static Color get defaultColor => Preferences.themeColor == null
      ? supportColors.first
      : Color(Preferences.themeColor!);

  static const blackBold = Color(0xff332C2C);

  static const fontGrayLead = Color(0xff646464);

  static const fontGreen = Color(0xff00BAB3);

  static const purple = Color(0xff6B7CFF);

  static const fontGray = Color(0xff95A8B5);

  static const fontGray3 = Color(0xff828282);

  static const lightGray = Color(0xffF2F2F5);

  static const black = Color(0xff211A1A);

  static const box = Color(0xffD4D4D4);

  static const boxFont = Color(0xffAFAFAF);

  static const fontBoldLight = Color(0xff565656);

  static const middleGray = Color(0xffC0C8CD);

  static const perlGreen = Color(0xffF1F8F7);

  static const icon = Color(0xffBDBDBD);

  static const background = Color(0xffF9FBFB);

  static const pink = Color(0xffEA497B);

  static const pink1 = Color(0xffFFE4EC);

  static const textiked = Color(0xffE3E3E3);

  static const fontBlue = Color(0xff40A3FF);

  static const fontBlue1 = Color(0xffD7F1FF);

  static const lightStatusBar = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static const darkStatusBar = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static const supportColors = <Color>[
    Color(0xff47C3BE),
    Color(0xff55BE81),
    Color(0xffFF3976),
    Color(0xffFF5D5D),
    Color(0xffEE5266),
    Color(0xff6B7CFF),
    Color(0xff40A3FF),
    Color(0xffFF8A48),
    Color(0xffFCA600),
    Color(0xffACAEB5),
    Color(0xff575F74),
    Color(0xff4F4F4F),
  ];

  static Color findByValue(int value) {
    return supportColors.firstWhere((e) => e.value == value);
  }

  static const surface = Color(0xffF5F8FA);
  static const title = Color(0xff6d7175);
  static const dividerColor = Color(0xffE5E5E5);
  static const defaultGrey = Color(0xffBDBDBD);

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
        systemOverlayStyle: lightStatusBar,
        iconTheme: const IconThemeData(color: Colors.white),
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

// class _AndroidCustomPageTransitionBuilder extends PageTransitionsBuilder {
//   const _AndroidCustomPageTransitionBuilder();
//   @override
//   Widget buildTransitions<T>(
//     PageRoute<T> route,
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     return FadeTransition(
//       opacity: animation.drive(CurveTween(curve: Curves.easeInOutQuart)),
//       child: ScaleTransition(
//         scale: Tween<double>(begin: 1.1, end: 1).animate(animation),
//         child: child,
//       ),
//     );
//   }
// }
