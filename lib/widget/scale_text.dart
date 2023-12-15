part of '../media_picker.dart';

class ScaleText extends StatelessWidget {
  const ScaleText(
    this.text, {
    super.key,
    this.style,
    this.strutStyle,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.semanticsLabel,
    this.softWrap,
    this.minScaleFactor = 0.7,
    this.maxScaleFactor = 1.3,
  });

  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final String? semanticsLabel;
  final bool? softWrap;

  final double minScaleFactor;
  final double maxScaleFactor;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mqd = MediaQuery.of(context);
    final textScaler = mqd.textScaler.clamp(
      minScaleFactor: minScaleFactor,
      maxScaleFactor: maxScaleFactor,
    );

    return MediaQuery(
      data: mqd.copyWith(textScaler: textScaler),
      child: Text(
        text,
        style: style,
        strutStyle: strutStyle,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        textDirection: textDirection,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
      ),
    );
  }
}
