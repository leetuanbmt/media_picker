import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import 'widget.dart';

class MyPageBottomSheet {
  void showBottomSheet(
    BuildContext context,
    Widget widget,
    VoidCallback? voidCallback,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.8,
      ),
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
          ),
          child: widget,
        );
      },
    ).whenComplete(() {
      voidCallback!();
    });
  }
}

class ReportUserBottomSheet extends StatelessWidget {
  const ReportUserBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3.r)),
      borderSide: BorderSide(
        width: 1.r,
        color: AppTheme.box,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.w,
        right: 16.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: AppTheme.icon,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              context.tr(LocaleKeys.userReports),
              style: context.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xff4F4F4F),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: context.tr(LocaleKeys.reportViolationsByUser),
                hintStyle: context.titleSmall!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: AppTheme.boxFont,
                ),
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: context.screenPadding.bottom,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  return ButtonCustom(
                    context.tr(LocaleKeys.report),
                    height: 48.h,
                    width: 327.w,
                    fontSize: 15.sp,
                    onPressed: () {
                      Navigator.pop(context);
                      ref.read(myPageProvider).blockUser();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectCoinBottomSheet extends ConsumerWidget {
  const SelectCoinBottomSheet({
    super.key,
  });

  void showChargeSheet(BuildContext context) {
    MyPageBottomSheet()
        .showBottomSheet(context, const SelectChargeBottomSheet(), null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(myPageProvider);

    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(2.r),
      borderSide: BorderSide(
        width: 1.r,
        color: AppTheme.boxFont,
      ),
    );

    List points = [
      '10',
      '50',
      '100',
      '500',
      '1000',
      '2000',
      '5000',
      '10000',
      '30000',
      '50000',
    ];

    ValueNotifier<int> pointSelected = ValueNotifier<int>(-1);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24.w,
        right: 24.w,
      ),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.close_sharp,
                color: AppTheme.icon,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    context.tr(LocaleKeys.possessionPoints),
                    style: style.copyWith(
                      fontSize: 14.sp,
                      color: AppTheme.fontGrayLead,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Assets.iconsIcCoin.svg(),
                      SizedBox(
                        width: 6.51.w,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '99999',
                          style: context.titleLarge!.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: 'pt',
                              style: style,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ButtonCustom(
                context.tr(LocaleKeys.charge),
                onPressed: () {
                  showChargeSheet(context);
                },
                height: 31.h,
                width: 103.w,
                backgroundColor: AppTheme.purple,
                fontSize: 12.sp,
              ),
            ],
          ),
          SizedBox(
            height: 16.2.h,
          ),
          GridView.builder(
            itemCount: points.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 13.48.w,
              mainAxisExtent: 47.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                valueListenable: pointSelected,
                builder: (context, value, _) {
                  return ButtonCustom(
                    points[index],
                    height: 48.h,
                    width: 154.66.w,
                    borderWidth: 2.r,
                    fontSize: 16.sp,
                    radius: 12.r,
                    type: pointSelected.value == index
                        ? ButtonType.normal
                        : ButtonType.outline,
                    onPressed: () {
                      pointSelected.value = index;
                    },
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 9.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
                width: 154.66.w,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: provider.coinInputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: border,
                    enabledBorder: border,
                    filled: true,
                    fillColor: const Color(0xffF0F3F7),
                    contentPadding: EdgeInsets.only(top: 4.h),
                  ),
                ),
              ),
              SizedBox(
                width: 5.34.w,
              ),
              Text(
                'pt',
                style: style.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.56.h,
          ),
          Consumer(
            builder: (context, ref, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SwitchButtonSetting(
                    context.tr(LocaleKeys.delaySetting),
                    ref.watch(
                      myPageProvider
                          .select((value) => value.delayController.text),
                    ),
                    ref.watch(
                      myPageProvider.select(
                        (value) => value.isDelaySetting,
                      ),
                    ),
                    () {
                      MyPageBottomSheet().showBottomSheet(
                        context,
                        SettingBottomSheet(
                          title: context.tr(
                            LocaleKeys.delaySetting,
                          ),
                          content: context.tr(LocaleKeys.noteAboutDelaySetting),
                          controller: provider.delayController,
                          listItems: provider.delayItems,
                        ),
                        null,
                      );
                    },
                    (value) {
                      provider.changeDelaySetting(value);
                    },
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  SwitchButtonSetting(
                    context.tr(LocaleKeys.autoSetting),
                    ref.watch(
                      myPageProvider
                          .select((value) => value.autoController.text),
                    ),
                    ref.watch(
                      myPageProvider.select(
                        (value) => value.isAutoSetting,
                      ),
                    ),
                    () {
                      MyPageBottomSheet().showBottomSheet(
                        context,
                        SettingBottomSheet(
                          title: context.tr(
                            LocaleKeys.autoSetting,
                          ),
                          content: context.tr(LocaleKeys.noteAboutAutoSetting),
                          controller: provider.autoController,
                          listItems: provider.autoItems,
                        ),
                        null,
                      );
                    },
                    (value) {
                      provider.changeAutoSetting(value);
                    },
                  ),
                ],
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return SizedBox.square(
                    dimension: 24.r,
                    child: Checkbox(
                      value: ref.watch(
                        myPageProvider.select(
                          (value) => value.isSaveSetting,
                        ),
                      ),
                      side: const BorderSide(
                        color: AppTheme.icon,
                        width: 1,
                      ),
                      onChanged: (bool? value) {
                        provider.changeSaveSetting(value!);
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                context.tr(LocaleKeys.saveSettings),
                style: style.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.19.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
            child: ButtonCustom(
              context.tr(LocaleKeys.sendPoints),
              height: 48.h,
              width: 327.w,
              onPressed: () {
                Navigator.of(context).pop();
                provider.showTimeRemaining();
                Future.delayed(const Duration(seconds: 10), () {
                  provider.showTimeRemaining();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SelectChargeBottomSheet extends StatelessWidget {
  const SelectChargeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> pointSelected = ValueNotifier<int>(-1);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.close_sharp,
                color: AppTheme.icon,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Text(
            context.tr(LocaleKeys.possessionPoints),
            style: context.titleSmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.iconsIcCoin.svg(
                width: 31.32.w,
                height: 31.97.h,
              ),
              SizedBox(width: 11.65.w),
              Text(
                '2000',
                style: context.headlineLarge!.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 375.w,
                height: 74.h,
                child: Row(
                  children: [
                    Assets.iconsIcCoin.svg(
                      width: 19.16.w,
                      height: 21.9.h,
                    ),
                    SizedBox(
                      width: 8.49.w,
                    ),
                    Text(
                      '500',
                      style: context.titleMedium!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 190.w,
                    ),
                    ValueListenableBuilder(
                      valueListenable: pointSelected,
                      builder: (context, value, child) {
                        return ButtonCustom(
                          index == 0 ? '￥650' : '￥1300',
                          width: 90.w,
                          height: 33.h,
                          type: value == index
                              ? ButtonType.normal
                              : ButtonType.outline,
                          onPressed: () {
                            pointSelected.value = index;
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: AppTheme.lightGray,
            ),
            itemCount: 5,
          ),
          SizedBox(
            height: 22.h,
          ),
          ValueListenableBuilder(
            valueListenable: pointSelected,
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ButtonCustom(
                      context.tr(LocaleKeys.buy),
                      width: 327.w,
                      height: 48.h,
                      backgroundColor: pointSelected.value == -1
                          ? AppTheme.middleGray
                          : AppTheme.primaryColor,
                      onPressed: () {
                        ref
                            .read(myPageProvider)
                            .chooseCharge(pointSelected.value);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingBottomSheet extends ConsumerWidget {
  const SettingBottomSheet({
    required this.title,
    required this.content,
    required this.controller,
    required this.listItems,
    super.key,
  });

  final String title;
  final String content;
  final TextEditingController controller;
  final List<DropdownMenuEntry<String>> listItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppTheme.box,
      ),
      borderRadius: BorderRadius.circular(4.r),
    );

    String itemSelected = '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.close_sharp,
                color: AppTheme.icon,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Text(
            title,
            style: context.titleLarge!.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            content,
            style: context.labelLarge!.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
              color: AppTheme.fontGrayLead,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          DropdownMenu(
            width: 328.37.w,
            textStyle: context.titleMedium!.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: AppTheme.boxFont,
            ),
            dropdownMenuEntries: listItems,
            inputDecorationTheme: InputDecorationTheme(
              constraints: BoxConstraints(maxHeight: 48.h),
              focusedBorder: border,
              enabledBorder: border,
              contentPadding: EdgeInsets.only(
                left: 12.w,
              ),
            ),
            trailingIcon: const Icon(
              color: AppTheme.icon,
              Icons.keyboard_arrow_down_rounded,
            ),
            onSelected: (value) {
              itemSelected = value!;
            },
          ),
          SizedBox(
            height: 40.h,
          ),
          Consumer(
            builder: (context, ref, child) {
              return Padding(
                padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
                child: ButtonCustom(
                  context.tr(LocaleKeys.set),
                  height: 48.h,
                  width: 327.w,
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref
                        .read(myPageProvider)
                        .updateValueSetting(controller, itemSelected);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ControlRequestBottomSheet extends ConsumerWidget {
  const ControlRequestBottomSheet({super.key});

  void showChargeSheet(BuildContext context) {
    MyPageBottomSheet()
        .showBottomSheet(context, const SelectChargeBottomSheet(), null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<int> pointSelected = ValueNotifier<int>(-1);

    List points = ['1000', '2000', '5000', '10000', '30000', '50000'];

    final provider = ref.read(myPageProvider);

    final isValid = ref.watch(
      myPageProvider.select((value) => value.validControlRequest),
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(2.r),
      borderSide: BorderSide(
        width: 1.r,
        color: isValid ? AppTheme.boxFont : const Color(0xffFF7373),
      ),
    );

    final style = context.labelLarge!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.fontGrayLead,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: AppTheme.icon,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              context.tr(LocaleKeys.controlRequestSettings),
              style: context.titleLarge!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.blackBold,
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 21.w),
              child: Text(
                context.tr(LocaleKeys.possessionPoints),
                style: style,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Assets.iconsIcCoin.svg(
                      width: 14.69.w,
                      height: 16.79.h,
                    ),
                    SizedBox(
                      width: 6.51.w,
                    ),
                    Text(
                      '99999',
                      style: context.headlineSmall!.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'pt',
                      style: context.labelMedium!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ButtonCustom(
                  context.tr(LocaleKeys.charge),
                  onPressed: () {
                    showChargeSheet(context);
                  },
                  height: 31.h,
                  width: 103.w,
                  backgroundColor: AppTheme.purple,
                ),
              ],
            ),
            SizedBox(
              height: 21.h,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7.4.h,
                crossAxisSpacing: 13.48.w,
                mainAxisExtent: 48.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: points.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: pointSelected,
                  builder: (context, value, child) {
                    return ButtonCustom(
                      points[index],
                      height: 48.h,
                      width: 154.66.w,
                      borderWidth: 2.r,
                      fontSize: 16.sp,
                      radius: 5.r,
                      type: pointSelected.value == index
                          ? ButtonType.normal
                          : ButtonType.outline,
                      onPressed: () {
                        pointSelected.value = index;
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 9.6.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 49.h,
                  width: 152.71.w,
                  child: Consumer(
                    builder: (context, ref, child) {
                      return TextField(
                        textAlign: TextAlign.center,
                        controller: provider.controlRequestController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isValid
                              ? const Color(0xffF0f3f7)
                              : const Color(0xffFFE9E9),
                          border: border,
                          focusedBorder: border,
                          contentPadding: EdgeInsets.only(top: 4.h),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 5.34.w,
                ),
                Text(
                  'pt',
                  style: style.copyWith(color: AppTheme.blackBold),
                ),
              ],
            ),
            isValid
                ? SizedBox(
                    height: 24.h,
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      context.tr(LocaleKeys.requestRequires),
                      style: style.copyWith(
                        color: const Color(0xffEB5757),
                      ),
                    ),
                  ),
            Consumer(
              builder: (context, ref, child) {
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: context.screenPadding.bottom),
                  child: ButtonCustom(
                    context.tr(LocaleKeys.sendRequest),
                    height: 42.h,
                    width: 327.w,
                    fontSize: 15.sp,
                    onPressed: () {
                      if (provider.checkValidControlRequest()) {
                        Navigator.of(context).pop();
                        ref
                            .read(myPageProvider)
                            .updateRequestStatus('requesting');
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmFinishBottomSheet extends StatelessWidget {
  const ConfirmFinishBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.bodySmall!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppTheme.blackBold,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.5.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.screenWidth,
            height: 40.38.h,
          ),
          Text(
            context.tr(LocaleKeys.confirmFinish),
            style: context.titleLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.blackBold,
            ),
          ),
          SizedBox(
            height: 24.62.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.tr(LocaleKeys.remainingPoints),
                style: style,
              ),
              SizedBox(
                width: 4.33.w,
              ),
              Assets.iconsIcCoin.svg(
                width: 26.35.w,
                height: 26.83.h,
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                '20000',
                style: context.headlineSmall!.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.blackBold,
                  letterSpacing: 2.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  context.tr('pt'),
                  style: style,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonCustom(
                  context.tr(LocaleKeys.cancel),
                  height: 48.h,
                  width: 162.w,
                  borderWidth: 2.r,
                  fontSize: 15.sp,
                  type: ButtonType.outline,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ButtonCustom(
                      context.tr(LocaleKeys.finish),
                      height: 48.h,
                      width: 162.w,
                      borderWidth: 2.r,
                      fontSize: 15.sp,
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(myPageProvider).updateShowDeviceControlling();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
