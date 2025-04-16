import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../core/config.dart';
import '../core/hooks/configurations/use_effect_deactivate.dart';
import '../core/providers/user_provider.dart';
import '../core/routes/app_routes.gr.dart';
import '../core/utilities/db_helper.dart';
import '../widgets/commons/app_lifecycle.dart';

class TabItem {
  const TabItem({
    required this.title,
    required this.image,
  });

  final String title;
  final String image;
}

@RoutePage()
class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  void setUserState(bool isOnline) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance
        .collection(DbCollection.users)
        .doc(uid)
        .update(<String, dynamic>{'isOnline': isOnline});
  }

  void showToastConnect(BuildContext context, InternetStatus state) {
    final isConnect = state == InternetStatus.connected;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isConnect ? Icons.wifi : Icons.wifi_off,
              color: context.colorScheme.onPrimary,
            ),
            const SizedBox(width: 10),
            Text(isConnect
                ? context.lang.connection_restored
                : context.lang.you_are_offline),
          ],
        ),
        backgroundColor: context.colorScheme.primary,
        showCloseIcon: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectDeactivate(
      effect: () {
        ref.read(userProvider).initialize();
        setUserState(true);
        final subscription =
            InternetConnection().onStatusChange.listen((status) {
          if (!context.mounted) return;
          showToastConnect(context, status);
        });
        return () {
          Logger.log('DashboardScreen dispose');
          subscription.cancel();
        };
      },
      deactivate: () {
        Logger.log('DashboardScreen deactivate');
        ref.read(userProvider).stopStream();
        setUserState(false);
      },
      keys: const [],
    );

    return AppLifecycleWidget(
      onResumed: () => setUserState(true),
      onInactive: () => setUserState(false),
      child: AutoTabsScaffold(
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
                tabsRouter.topRoute.router.maybePop();
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
          );
        },
      ),
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
        title: context.lang.home,
        image: Assets.iconsIconHome.path,
      ),
      TabItem(
        title: context.lang.search,
        image: Assets.iconsIconSearch.path,
      ),
      TabItem(
        title: 'Main',
        image: Assets.iconsIconApp.path,
      ),
      TabItem(
        title: context.lang.notification,
        image: Assets.iconsIconNotifications.path,
      ),
      TabItem(
        title: context.lang.myPage,
        image: Assets.iconsIconPerson.path,
      ),
    ];
    return Container(
      height: kBottomNavigationBarHeight.h + context.padding.bottom,
      padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(
        bottom: context.padding.bottom / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        //box shadow top navigator bar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
        color: Colors.transparent,
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
