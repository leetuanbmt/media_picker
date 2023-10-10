import '../../../../core/config.dart';
import '../../../../providers/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';

class RegisterCategoryScreen extends StatelessWidget {
  const RegisterCategoryScreen({super.key, required this.onNextPage});
  final Function onNextPage;

  @override
  Widget build(BuildContext context) {
    List<String> listCategories = [
      '🕺 ステージ',
      '🎵 音楽',
      '🔈 メディア',
      '😂 お笑い',
      '🎭 演技',
      '🎩 コスプレ',
      '📚 漫画',
      '🎮 ゲーム',
      '🤡 アニメ',
      '💅 美容',
      '⚾️ スポーツ',
      '🎨 アート',
      '👗 ファッション',
      '👥 コミュニティ',
      '🤝 チャリティ',
      '📊 経済',
      '‍🎓 教育',
    ];

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
            children: listCategories
                .map(
                  (e) => Consumer(
                    builder: (context, ref, child) {
                      final isSelected = ref.watch(
                        registerProvider
                            .select((value) => value.checkCategoryActive(e)),
                      );
                      final register = ref.watch(registerProvider.notifier);

                      return ButtonCustom(
                        e,
                        fontSize: 15.sp,
                        onPressed: () {
                          register.updateCategory(e);
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
                    registerProvider
                        .select((value) => value.checkCategoryEmpty),
                  );
                  return ButtonCustom(
                    "次へ",
                    height: 48.h,
                    width: 162.w,
                    backgroundColor: isActiveButton
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      isActiveButton ? null : onNextPage();
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
