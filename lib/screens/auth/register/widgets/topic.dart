import '../../../../core/config.dart';
import '../../../../core/providers/auth/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';

class RegisterTopicScreen extends StatelessWidget {
  const RegisterTopicScreen({super.key, required this.onNextPage});

  final VoidCallback onNextPage;

  @override
  Widget build(BuildContext context) {
    List<String> listTopic = [
      '‍🎤 配信',
      '‍📣 店舗',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(
            height: 37.h,
          ),
          Text(
            context.lang.purposeUse,
            style: context.textTheme.titleLarge!.copyWith(
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
            children: listTopic
                .map(
                  (e) => Consumer(
                    builder: (context, ref, child) {
                      final isSelected = ref.watch(
                        registerProvider
                            .select((value) => value.checkUsageActive(e)),
                      );
                      final provider = ref.read(registerProvider.notifier);

                      return ButtonCustom(
                        e,
                        fontSize: 18.sp,
                        height: 48.h,
                        width: 108.w,
                        onPressed: () {
                          provider.updateUsage(e);
                        },
                        type:
                            isSelected ? ButtonType.normal : ButtonType.outline,
                        textColor: isSelected ? Colors.white : null,
                        borderWidth: 2.w,
                        padding: EdgeInsets.all(10.r),
                      );
                    },
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
                  final isActiveButton = ref.watch(
                    registerProvider.select((value) => value.checkUsageEmpty),
                  );
                  return ButtonCustom(
                    context.lang.toTheNext,
                    height: 48.h,
                    width: 162.w,
                    backgroundColor: isActiveButton
                        ? AppTheme.middleGray
                        : context.primaryColor,
                    onPressed: () {
                      if (isActiveButton) return;
                      onNextPage();
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
