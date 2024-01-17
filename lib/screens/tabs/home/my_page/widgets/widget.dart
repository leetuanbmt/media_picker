import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';

class TimeReMainingIndicator extends StatefulWidget {
  const TimeReMainingIndicator({
    super.key,
    this.sliderValue = 8.0,
  });

  final double sliderValue;

  @override
  State<TimeReMainingIndicator> createState() => _TimeReMainingIndicatorState();
}

class _TimeReMainingIndicatorState extends State<TimeReMainingIndicator> {
  List<Color> itemColors = [];

  double defaultSliderValue = 0;
  ValueNotifier<double> sliderValue = ValueNotifier<double>(0);
  ValueNotifier<double> dragPosition = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    sliderValue.value = widget.sliderValue;
    itemColors = List<Color>.filled(27, AppTheme.box);
  }

  void updateItemColors() {
    for (int i = 0; i < itemColors.length; i++) {
      if (i < dragPosition.value) {
        itemColors[i] = AppTheme.pink;
      } else {
        itemColors[i] = AppTheme.box;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 73.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: AppTheme.blackBold,
          ),
          child: ValueListenableBuilder(
            valueListenable: dragPosition,
            builder: (context, value, child) {
              return Text(
                '${(dragPosition.value * 11.12).toInt()}mb', // MAX 300mp /27 = 11.12
                style: context.titleMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        CustomPaint(
          painter: TrianglePainter(),
          size: Size(9.5.w, 8.h),
        ),
        SizedBox(
          height: 10.h,
        ),
        ValueListenableBuilder(
          valueListenable: dragPosition,
          builder: (context, value, child) {
            return Container(
              height: 52.h,
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colors.white,
              ),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  dragPosition.value += details.delta.dx / 11.12;
                  if (dragPosition.value < 0) {
                    dragPosition.value = 0;
                  } else if (dragPosition.value > 27) {
                    dragPosition.value = 27;
                  }
                  updateItemColors();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    27,
                    (index) => Container(
                      width: 6.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: itemColors[index],
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 15.57.h,
        ),
        Container(
          width: 337.07.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            color: const Color(0xffF2F2F2),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 8,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ValueListenableBuilder(
            valueListenable: sliderValue,
            builder: (context, value, child) {
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: sliderValue.value > 0 ? 44.h : 0,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: sliderValue.value >= 1 ? 22.7 : 1,
                    elevation: 0,
                  ),
                  trackShape: CustomSliderTrackShape(),
                  activeTrackColor: const Color(0xff8F3FFC),
                  inactiveTrackColor: const Color(0xffF2F2F2),
                  thumbColor: sliderValue.value >= 1
                      ? const Color(0xff8F3FFC)
                      : const Color(0xffF2F2F2),
                ),
                child: ValueListenableBuilder(
                  valueListenable: sliderValue,
                  builder: (context, value, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Slider(
                          value: sliderValue.value,
                          min: 0,
                          max: 10.0,
                          onChanged: (newValue) {
                            setState(() {
                              sliderValue.value = newValue;
                            });
                          },
                        ),
                        if (sliderValue.value > 1)
                          Positioned(
                            left: sliderValue.value * 15.2,
                            child: Text(
                              '${sliderValue.value.round().toString()}${context.lang.seconds}',
                              style: context.bodyMedium!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    return Rect.fromLTWH(offset.dx, 0, (337.07 - 22.7).w, 44.h);
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.blackBold
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TextItem extends StatelessWidget {
  const TextItem({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: context.bodySmall!.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

class SwitchButtonSetting extends StatelessWidget {
  const SwitchButtonSetting(
    this.content,
    this.valueSelected,
    this.valueSetting,
    this.onPressed,
    this.onChanged, {
    super.key,
  });

  final String content;
  final String valueSelected;
  final bool valueSetting;
  final VoidCallback onPressed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          height: 64.h,
          width: 141.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 31.h,
                    width: 51.w,
                    child: CupertinoSwitch(
                      activeColor: context.primaryColor,
                      value: valueSetting,
                      onChanged: onChanged,
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    content,
                    style: style.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              if (valueSetting)
                SizedBox(
                  height: 24.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        valueSelected,
                        style: style.copyWith(
                          color: AppTheme.fontGray3,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(48.w, 24.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          backgroundColor: AppTheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.r),
                            ),
                            side: BorderSide(
                              width: 1.r,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: onPressed,
                        child: Text(
                          context.lang.change,
                          style: style.copyWith(
                            color: context.primaryColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
