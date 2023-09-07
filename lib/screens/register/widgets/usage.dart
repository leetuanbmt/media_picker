import '../../../core/config.dart';
import '../../../widgets/commons/button_custom.dart';

class RegisterUsageScreen extends HookWidget {
  const RegisterUsageScreen({super.key, required this.onNextPage});

  final Function onNextPage;

  @override
  Widget build(BuildContext context) {
    List<String> active = [];
    final categories = useState<List<String>>([...active]);
    List<String> listCategory = [
      '‍🎤 配信',
      '‍📣 店舗',
    ];
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 37.h,
          ),
          Text(
            'ユーザー名を決定しましょう',
            style: context.titleLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.blackBold,
            ),
          ),
          SizedBox(
            height: 38.h,
          ),
          Wrap(
            spacing: 8.w,
            children: listCategory
                .map(
                  (e) => ButtonCustom(
                    e,
                    fontSize: 18.sp,
                    height: 48.h,
                    width: 108.w,
                    onPressed: () {
                      if (categories.value.contains(e)) {
                        categories.value = [...categories.value..remove(e)];
                      } else {
                        categories.value = [...categories.value..add(e)];
                      }
                    },
                    type: categories.value.contains(e)
                        ? ButtonType.normal
                        : ButtonType.outline,
                    textColor:
                        categories.value.contains(e) ? Colors.white : null,
                    borderWidth: 2.w,
                    padding: EdgeInsets.all(10.r),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 477.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonCustom(
                "次へ",
                height: 48.h,
                width: 162.w,
                backgroundColor: categories.value.isEmpty
                    ? AppTheme.middleGray
                    : AppTheme.primaryColor,
                onPressed: () {
                  categories.value.isEmpty ? null : onNextPage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
