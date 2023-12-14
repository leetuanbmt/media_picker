import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/config.dart';
import '../core/utilities/db_helper.dart';
import '../gen/assets.gen.dart';
import '../providers/user_provider.dart';
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
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    ref.read(userProvider).initialize();
    setUserState(true);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Logger.log(state);
    switch (state) {
      case AppLifecycleState.resumed:
        setUserState(true);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        setUserState(false);
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    ref.read(userProvider).stopStream();
    super.deactivate();
  }

  void setUserState(bool isOnline) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance
        .collection(DbCollection.users)
        .doc(uid)
        .update(<String, dynamic>{'isOnline': isOnline});
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeTabRoute(),
        SearchRoute(),
        MainRoute(),
        NotificationRoute(),
        ProfileTabRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return child;
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return _BottomNavigation(
          currentIndex: tabsRouter.activeIndex,
          onChange: (index) {
            if (index == tabsRouter.activeIndex) {
              tabsRouter.topRoute.router.pop();
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
    required this.currentIndex,
    required this.onChange,
  });
  final int currentIndex;
  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TabItem(
        title: context.tr(LocaleKeys.home),
        image: Assets.iconsIconHome.path,
      ),
      TabItem(
        title: context.tr(LocaleKeys.search),
        image: Assets.iconsIconSearch.path,
      ),
      TabItem(
        title: 'Main',
        image: Assets.iconsIconApp.path,
      ),
      TabItem(
        title: context.tr(LocaleKeys.notification),
        image: Assets.iconsIconNotifications.path,
      ),
      TabItem(
        title: context.tr(LocaleKeys.myPage),
        image: Assets.iconsIconPerson.path,
      ),
    ];
    return Container(
      height: kBottomNavigationBarHeight.h + context.screenPadding.bottom,
      padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(
        bottom: context.screenPadding.bottom / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        //box shadow top navigator bar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -1),
          ),
        ],
      ),
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
                      onTap: onChange,
                    )
                  : _MainTabCustom(
                      tab: e.value,
                      index: e.key,
                      onTap: onChange,
                    ),
            )
            .toList(),
      ),
    );
  }
}

class _BottomTabItem extends StatelessWidget {
  const _BottomTabItem({
    required this.tab,
    required this.onTap,
    required this.index,
    this.currentIndex = 0,
  });

  final TabItem tab;

  final ValueChanged<int> onTap;

  final int currentIndex, index;

  bool get isActive => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? context.primaryColor : AppTheme.defaultGrey;
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () => onTap.call(index),
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
                minFontSize: 8,
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
    required this.index,
  });

  final int index;
  final TabItem tab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Material(
        color: context.primaryColor,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onTap.call(index),
          child: SizedBox.square(
            dimension: 48,
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
    );
  }
}
