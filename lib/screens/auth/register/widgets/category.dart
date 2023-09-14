import '../../../../core/config.dart';
import '../../../../core/models/register/fan_model.dart';
import '../../../../widgets/commons/button_custom.dart';

class RegisterCategoryScreen extends HookConsumerWidget {
  const RegisterCategoryScreen({super.key, required this.onNextPage});
  final Function onNextPage;

  void registerCategory() {
    onNextPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> active = [];
    final categories = useState<List<String>>([...active]);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Text(
            'あなたにあてはまるカテゴリを\n選択してください',
            textAlign: TextAlign.center,
            style: context.titleLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.blackBold,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Wrap(
            spacing: 4.w,
            runSpacing: 12.h,
            children: FanModel.listCategories
                .map(
                  (e) => ButtonCustom(
                    e,
                    fontSize: 15.sp,
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
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return ButtonCustom(
                    "次へ",
                    height: 48.h,
                    width: 162.w,
                    backgroundColor: categories.value.isEmpty
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      categories.value.isEmpty ? null : registerCategory();
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 27.h,
          ),
        ],
      ),
    );
  }
}
