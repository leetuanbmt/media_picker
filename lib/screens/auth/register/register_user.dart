import '../../../core/config.dart';
import '../../../core/models/enum/enum.dart';
import '../../../gen/assets.gen.dart';
import '../../../providers/auth/register_provider.dart';
import 'widgets/bank_account.dart';
import 'widgets/category.dart';
import 'widgets/topic.dart';
import 'widgets/user_information.dart';
import 'widgets/user_name.dart';

@RoutePage()
class RegisterUserScreen extends ConsumerWidget {
  const RegisterUserScreen({super.key, required this.userType});
  final UserType userType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(registerProvider);
    final activePage =
        ref.watch(registerProvider.select((value) => value.activePage));

    final List<Widget> pageTab = [
      RegisterUserInformation(
        onNextPage: () => provider.changePage(),
      ),
      RegisterUserName(
        onNextPage: () => provider.changePage(),
      ),
      RegisterTopicScreen(
        onNextPage: () => provider.changePage(),
      ),
      RegisterCategoryScreen(
        onNextPage: () => provider.changePage(),
      ),
      RegisterBankAccountScreen(
        userType: userType,
      ),
    ];
    if (userType == UserType.fan) {
      pageTab.removeAt(0);
    }

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.square(
          dimension: 24.h,
          child: InkWell(
            onTap: () {
              if (activePage > 0) {
                provider.pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linearToEaseOut,
                );
              } else {
                provider.refresh(userType);
                context.back();
              }
            },
            child: Assets.iconsIconArrowLeft.svg(
              width: 10.88.w,
              height: 18.47.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(right: 56.w),
          child: Consumer(
            builder: (context, ref, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 16.w,
                    children: [
                      ...List<Widget>.generate(
                        pageTab.length,
                        (index) => SizedBox.square(
                          dimension: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(
                              activePage == index ? 1 : 0.7,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: PageView(
        controller: provider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int page) {
          provider.changeActivePage(page);
        },
        children: pageTab.map((e) => _KeepAliveTab(child: e)).toList(),
      ),
    );
  }
}

class _KeepAliveTab extends StatefulWidget {
  const _KeepAliveTab({required this.child});
  final Widget child;

  @override
  State<_KeepAliveTab> createState() => __KeepAliveTabState();
}

class __KeepAliveTabState extends State<_KeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
