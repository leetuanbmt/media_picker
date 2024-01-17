part of '../config.dart';

class AppColor extends Color {
  final String name;

  const AppColor(super.color, {required this.name});

  const AppColor.from(super.value, {required this.name});

  factory AppColor.fromString(String string) {
    final slices = string.split(':');
    return AppColor(int.parse(slices.last), name: slices.first);
  }

  @override
  String toString() {
    return '$name:$value';
  }
}

class AppTheme {
  AppTheme._();

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
  static final Set<AppColor> supportColors = {
    AppColor(Colors.indigo.value, name: 'Indigo'),
    AppColor(Colors.red.value, name: 'Red'),
    AppColor(Colors.pink.value, name: 'Pink'),
    AppColor(Colors.purple.value, name: 'Purple'),
    AppColor(Colors.deepPurple.value, name: 'DeepPurple'),
    AppColor(Colors.blue.value, name: 'Blue'),
    AppColor(Colors.lightBlue.value, name: 'LightBlue'),
    AppColor(Colors.cyan.value, name: 'Cyan'),
    AppColor(Colors.teal.value, name: 'Teal'),
    AppColor(Colors.green.value, name: 'Green'),
    AppColor(Colors.lightGreen.value, name: 'LightGreen'),
    AppColor(Colors.yellow.value, name: 'Yellow'),
    AppColor(Colors.amber.value, name: 'Amber'),
    AppColor(Colors.orange.value, name: 'Orange'),
    AppColor(Colors.deepOrange.value, name: 'DeepOrange'),
    AppColor(Colors.brown.value, name: 'Brown'),
  };

  static Color findByValue(int value) {
    return supportColors.firstWhere((e) => e.value == value);
  }

  static const surface = Color(0xffF5F8FA);
  static const title = Color(0xff6d7175);
  static const dividerColor = Color(0xffE5E5E5);
  static const defaultGrey = Color(0xffBDBDBD);

  static const LinearGradient storyGradient = LinearGradient(
    colors: <Color>[Colors.blue, Colors.purple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static ThemeData appTheme(Color primaryColor, Brightness brightness) {
    ColorScheme colorScheme = ColorScheme.fromSeed(
      primary: primaryColor,
      seedColor: primaryColor,
      surface: surface,
      brightness: Brightness.light,
    );
    final themeData = ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      dividerColor: const Color(0x1F000000),
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
      buttonTheme: ButtonThemeData(buttonColor: primaryColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: Colors.transparent,
        indicatorColor: primaryColor,
        labelColor: primaryColor,
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
