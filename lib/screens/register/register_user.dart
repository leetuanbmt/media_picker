import '../../core/config.dart';
import '../../gen/assets.gen.dart';
import 'widgets/bank_account.dart';
import 'widgets/category.dart';
import 'widgets/information.dart';
import 'widgets/usage.dart';

@RoutePage()
class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 2;

  void changePage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildPage(index) {
      switch (index) {
        case 0:
          return RegisterInformationScreen(
            onNextPage: () => changePage(1),
          );

        case 1:
          return RegisterUsageScreen(
            onNextPage: () => changePage(2),
          );
        case 2:
          return RegisterCategoryScreen(
            onNextPage: () => changePage(3),
          );
        case 3:
          return RegisterBankAccountScreen(
            onNextPage: () => changePage(4),
          );
        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox.square(
              dimension: 24.w,
              child: InkWell(
                onTap: () {
                  if (_activePage > 2) {
                    changePage(_activePage - 3);
                  } else {
                    context.back();
                  }
                },
                child: Assets.iconsIconArrorLeft.svg(
                  width: 10.88.w,
                  height: 18.47.h,
                ),
              ),
            ),
            SizedBox(
              width: 85.w,
            ),
            Wrap(
              spacing: 16.w,
              children: [
                ...List<Widget>.generate(
                  6,
                  (index) => SizedBox.square(
                    dimension: 8,
                    child: CircleAvatar(
                      backgroundColor: _activePage == index
                          ? Colors.white
                          : const Color(0xffABE0DE),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int page) {
          setState(() {
            _activePage = page + 2;
          });
        },
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return buildPage(index);
        },
      ),
    );
  }
}
