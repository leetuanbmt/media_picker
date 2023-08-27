import 'package:flutter_svg/flutter_svg.dart';

import '../core/config.dart';
import '../gen/assets.gen.dart';
import '../routes/app_routes.gr.dart';

class TabItem {
  const TabItem({
    required this.title,
    required this.image,
  });

  final String title;
  final String image;
}

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeTabRoute(),
        SearchRoute(),
        MainRoute(),
        NotificationRoute(),
        ProfileRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return child;
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return _BottomNavigation(
          currentIndex: tabsRouter.activeIndex,
          onChange: (index) {
            if (index == tabsRouter.activeIndex) {
              if (tabsRouter.topRoute.router is NestedStackRouter) {
                tabsRouter.topRoute.router.navigateNamed('');
              }
            } else {
              tabsRouter.setActiveIndex(index);
            }
          },
        );
      },
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onChange,
  }) : super(key: key);
  final int currentIndex;
  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TabItem(
        title: 'ホーム',
        image: Assets.iconsIconHome.path,
      ),
      TabItem(
        title: '探す',
        image: Assets.iconsIconSearch.path,
      ),
      TabItem(
        title: 'Main',
        image: Assets.iconsIconApp.path,
      ),
      TabItem(
        title: 'お知らせ',
        image: Assets.iconsIconNotifications.path,
      ),
      TabItem(
        title: 'マイページ',
        image: Assets.iconsIconPerson.path,
      ),
    ];
    return SafeArea(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: tabs
                .asMap()
                .entries
                .map(
                  (e) => e.key != 2
                      ? _BottomTabItem(
                          tab: e.value,
                          index: e.key,
                          currentIndex: currentIndex,
                          onTap: () {
                            onChange.call(e.key);
                          },
                        )
                      : _MainTabCustom(
                          tab: e.value,
                          onTap: () {
                            onChange.call(e.key);
                          },
                        ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _BottomTabItem extends StatelessWidget {
  const _BottomTabItem({
    Key? key,
    required this.tab,
    required this.onTap,
    required this.index,
    this.currentIndex = 0,
  }) : super(key: key);

  final TabItem tab;

  final VoidCallback onTap;

  final int currentIndex, index;

  bool get isActive => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? context.primaryColor : AppTheme.defaultGrey;
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                tab.image,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              AutoSizeText(
                tab.title,
                style: TextStyle(
                  color: color,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainTabCustom extends StatelessWidget {
  const _MainTabCustom({
    required this.tab,
    required this.onTap,
  });
  final TabItem tab;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ClipOval(
        child: Material(
          color: context.primaryColor,
          child: InkWell(
            onTap: onTap,
            child: SizedBox.square(
              dimension: 48.r,
              child: SvgPicture.asset(
                tab.image,
                fit: BoxFit.scaleDown,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
