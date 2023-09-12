import '../../../../core/config.dart';
import '../../../../core/models/register/fan_model.dart';
import '../../../../providers/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';

class RegisterUsageScreen extends HookConsumerWidget {
  const RegisterUsageScreen({super.key, required this.onNextPage});

  final VoidCallback onNextPage;

  void registerUsage(WidgetRef ref, ValueNotifier<List<String>> categories) {
    ref.watch(registerProvider).changeUsage(categories.value);
    onNextPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> active = ref.read(registerProvider).userUsage;
    final categories = useState<List<String>>([...active]);

    return Consumer(
      builder: (context, ref, _) {
        return Padding(
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
                children: FanModel.listUsages
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
              const Spacer(),
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
                      categories.value.isEmpty
                          ? null
                          : registerUsage(ref, categories);
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
      },
    );
  }
}
