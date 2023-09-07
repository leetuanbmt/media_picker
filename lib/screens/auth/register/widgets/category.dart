import '../../../../core/config.dart';
import '../../../../widgets/commons/button_custom.dart';

class RegisterCategoryScreen extends HookWidget {
  const RegisterCategoryScreen({super.key, required this.onNextPage});
  final Function onNextPage;

  @override
  Widget build(BuildContext context) {
    List<String> active = [];
    final categories = useState<List<String>>([...active]);
    List<String> listCategory = [
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

    return Scaffold(
      body: SingleChildScrollView(
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
              children: listCategory
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
            SizedBox(
              height: 190.h,
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
      ),
    );
  }
}
