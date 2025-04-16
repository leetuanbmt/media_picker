import '../../../core/config.dart';
import '../../../widgets/commons/app_bar_custom.dart';

@RoutePage()
class UsagePlayScreen extends StatelessWidget {
  const UsagePlayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> listGuidePlay = [
      {
        'title': 'ライブ配信で',
        'image': Assets.imagesLiveStream.path,
      },
      {
        'title': 'ライブ配信で',
        'image': Assets.imagesAtStore.path,
      },
      {
        'title': 'ライブ配信で',
        'image': Assets.imagesConnect.path,
      },
      {
        'title': 'ライブ配信で',
        'image': Assets.imagesSinging.path,
      },
    ];

    final List<String> usageExample = [
      '・扇風機を動かす',
      '・電気のスイッチをオン/オフ',
      '・BluetoothでGoTipに連携できるルーレットで視聴者が１回500円のチップでルーレットを回す',
      '・歌を歌う配信者を盛り上げたい時に投げ銭してミラーボールを光らせる',
      '・飲み物サーバーがあるライブ配信で、視聴者が配信者に飲み物を提供',
      '・猫カフェにおいてあるネズミのおもちゃを動かす',
      '※すべて機器の接続が必要です。この他にも様々な使い方を試してみましょう。',
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        title: context.lang.usageGuide,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: context.screenWidth,
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.symmetric(vertical: 33.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '利用シーン',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              ...listGuidePlay.map((e) {
                return SizedBox(
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      Text(
                        e['title'] ?? '',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      Image.asset(
                        e['image'] ?? '',
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                );
              }),
              Gap(25.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextApp.bold(
                      '使い方の例',
                      type: TextType.xlg,
                    ),
                    Gap(31.h),
                    ...usageExample.map(
                      (e) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: TextApp(
                            e,
                            fontWeight: FontWeight.w300,
                            color: usageExample.last == e
                                ? context.primaryColor
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
