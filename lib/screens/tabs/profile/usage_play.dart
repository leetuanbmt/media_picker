import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';
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
      appBar: const AppBarCustom(
        title: '利用ガイド',
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
                  style: context.titleLarge?.copyWith(
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
                        style: context.titleMedium?.copyWith(
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
              }).toList(),
              SizedBox(height: 25.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '使い方の例',
                      style: context.titleLarge?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 31.h),
                    ...usageExample.map(
                      (e) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Text(
                            e,
                            style: context.titleLarge?.copyWith(
                              fontSize: 14.sp,
                              color: usageExample.last == e
                                  ? AppTheme.primaryColor
                                  : null,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        );
                      },
                    ).toList(),
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
