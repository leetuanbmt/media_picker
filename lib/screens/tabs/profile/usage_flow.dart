import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/commons/measure_size.dart';

@RoutePage()
class UsageFlowScreen extends StatefulWidget {
  const UsageFlowScreen({super.key});

  @override
  State<UsageFlowScreen> createState() => _UsageFlowScreenState();
}

class _UsageFlowScreenState extends State<UsageFlowScreen> {
  double widthText1 = 100;
  double widthText2 = 80;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const AppBarCustom(
        title: '利用の流れ',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Assets.imagesFan.image(height: 51.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: RichText(
                    text: TextSpan(
                      text: 'ファン',
                      style: context.titleMedium?.copyWith(
                        color: AppTheme.pink,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'として楽しむ',
                          style: context.titleMedium?.copyWith(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _UseGuideFlow(
                  title: 'ポイント\nを購入',
                  color: AppTheme.pink1,
                  image: Assets.imagesFlowStep1.image(),
                ),
                _UseGuideFlow(
                  title: 'クリエーター\nを探す',
                  color: AppTheme.pink1,
                  image: Assets.imagesFlowStep2.image(),
                ),
                _UseGuideFlow(
                  title: '投げ銭して\n機器を動かす',
                  color: AppTheme.pink1,
                  image: Assets.imagesFlowStep3.image(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 5.h),
              child: MeasureSize(
                onChange: (size) {
                  setState(() {
                    widthText1 += size.width;
                  });
                },
                child: Text(
                  '番外編 コントロールリクエスト',
                  style: context.titleLarge?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            _BubbleCustom(widthText1: widthText1),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: RichText(
                text: TextSpan(
                  text: 'ファン',
                  style: context.titleMedium?.copyWith(
                    color: AppTheme.purple,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'として楽しむ',
                      style: context.titleMedium?.copyWith(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _UseGuideFlow(
                  title: '機器を繋ぐ',
                  color: AppTheme.fontBlue1,
                  image: Assets.imagesFlowStep4.image(),
                ),
                _UseGuideFlow(
                  title: 'ファンを呼ぶ',
                  color: AppTheme.fontBlue1,
                  image: Assets.imagesFlowStep5.image(),
                ),
                _UseGuideFlow(
                  title: '投げ銭をもらう',
                  color: AppTheme.fontBlue1,
                  image: Assets.imagesFlowStep6.image(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 5.h),
              child: MeasureSize(
                onChange: (size) {
                  setState(() {
                    widthText2 += size.width;
                  });
                },
                child: Text(
                  'ポイントを稼ぐコツ',
                  style: context.titleLarge?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            _BubbleCustom(widthText1: widthText2),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class _BubbleCustom extends StatelessWidget {
  const _BubbleCustom({
    required this.widthText1,
  });

  final double widthText1;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomStyleArrow(width: widthText1.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.purple,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 14,
              offset: Offset(0, 15),
              color: Colors.black38,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Text(
          '保有獲得ポイントをチップ用ポイントとして変換し投げ銭に使用できます。',
          style: context.titleMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _UseGuideFlow extends StatelessWidget {
  const _UseGuideFlow({
    required this.title,
    this.color = AppTheme.pink1,
    this.image,
  });
  final String title;
  final Color? color;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: CircleAvatar(
            radius: 49.r,
            backgroundColor: color,
            child: Padding(
              padding: EdgeInsets.only(top: 27.h),
              child: image,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: context.labelSmall?.copyWith(fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CustomStyleArrow extends CustomPainter {
  final double width;

  CustomStyleArrow({required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppTheme.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    const double triangleH = 15;
    const double triangleW = 25.0;
    final double height = size.height;

    final Path trianglePath = Path()
      ..moveTo(width / 1.5 - triangleW / 2, 0)
      ..lineTo(width / 1.5, -triangleH)
      ..lineTo(width / 1.5 + triangleW / 2, 0)
      ..lineTo(width / 2 - triangleW / 2, 0);

    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(15.r);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
