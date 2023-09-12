import '../../../core/config.dart';
import '../../../core/models/enum/enum.dart';
import '../../../gen/assets.gen.dart';
import '../../../providers/register_provider.dart';
import 'widgets/bank_account.dart';
import 'widgets/category.dart';
import 'widgets/usage.dart';
import 'widgets/user_information.dart';
import 'widgets/user_name.dart';

@RoutePage()
class RegisterUserScreen extends HookConsumerWidget {
  const RegisterUserScreen({super.key, required this.userType});
  final UserType userType;

  void changePage(PageController pageController) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    final activePage = useState<int>(0);

    final List<Widget> pageTab = [
      RegisterUserInformation(
        onNextPage: () => changePage(pageController),
      ),
      RegisterUserName(
        onNextPage: () => changePage(pageController),
      ),
      RegisterUsageScreen(
        onNextPage: () => changePage(pageController),
      ),
      RegisterCategoryScreen(
        onNextPage: () => changePage(pageController),
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
              if (activePage.value > 0) {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linearToEaseOut,
                );
              } else {
                ref.read(registerProvider).clean();
                context.back();
              }
            },
            child: Assets.iconsIconArrorLeft
                .svg(width: 10.88.w, height: 18.47.h, fit: BoxFit.scaleDown),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(right: 56.w),
          child: Row(
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
                        backgroundColor: Colors.white
                            .withOpacity(activePage.value == index ? 1 : 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int page) {
          activePage.value = page;
        },
        children: pageTab,
      ),
    );
  }
}
