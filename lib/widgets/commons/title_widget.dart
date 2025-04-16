import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum TextLine { none, left, right, both }

enum TextType {
  /// font size [32]
  xxxlg(32),

  /// font size [24]
  xxlg(24),

  /// font size [20]
  xlg(20),

  lgMedium(18),

  /// font size [16]
  lg(16),

  mdMedium(15),

  /// font size [14]
  md(14),

  /// font size [12]
  sm(12),

  /// font size [13]
  xsm(13),

  /// font size [10]
  xs(10);

  const TextType(this.size);
  final double size;
}

class TextApp extends StatelessWidget {
  // Additional Factory Methods for Bold Titles
  factory TextApp.bold(
    String title, {
    TextLine line = TextLine.none,
    TextType type = TextType.md,
    int? maxLines,
    Color? color,
    double? height,
    double heightLine = 1,
    double? letterSpacing,
    TextOverflow? overflow,
    TextAlign? textAlign,
    bool isNotAutoSize = false,
    double spaceLine = 12,
    FontStyle? fontStyle,
    double? fontSize,
  }) =>
      TextApp(
        title,
        type: type,
        fontWeight: FontWeight.bold,
        maxLines: maxLines,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        line: line,
        overflow: overflow,
        heightLine: heightLine,
        textAlign: textAlign,
        isNotAutoSize: isNotAutoSize,
        spaceLine: spaceLine,
        fontStyle: fontStyle,
        fontSize: fontSize,
      );
  const TextApp(
    this.title, {
    super.key,
    this.type = TextType.md,
    this.color,
    this.line = TextLine.none,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.height,
    this.letterSpacing,
    this.overflow,
    this.heightLine = 1,
    this.textAlign,
    this.spaceLine = 12,
    this.isNotAutoSize = false,
    this.fontStyle,
    this.fontSize,
  });

  /// [title] String title to show
  final String title;

  /// [line] TextLine line to show
  /// [TextLine.none] no lin
  /// [TextLine.left] line on left, [Example] ----- Text
  /// [TextLine.right] line on right, [Example] Text -----
  /// [TextLine.both] line on both side, [Example] ----- Text -----
  /// default is [TextLine.none]
  final TextLine line;

  /// [heightLine] double height of line
  final double heightLine;

  /// [type] TextType type of text
  final TextType type;

  /// [fontWeight] FontWeight weight of text
  /// default is [FontWeight.normal]
  final FontWeight fontWeight;

  /// [maxLines] int max lines of text
  final int? maxLines;

  /// [color] Color color of text
  final Color? color;

  /// [height] double height of text
  final double? height;

  /// [letterSpacing] double letter spacing of text
  final double? letterSpacing;

  /// [overflow] TextOverflow overflow of text
  final TextOverflow? overflow;

  /// [textAlign] TextAlign textAlign of text
  final TextAlign? textAlign;

  /// [spaceLine] double space line of text
  final double spaceLine;

  /// [isNotAutoSize] bool is not auto size
  final bool isNotAutoSize;

  /// [fontStyle] FontStyle font style of text
  final FontStyle? fontStyle;

  /// [fontSize] double font size of text
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: fontWeight,
          color: color,
          height: height,
          letterSpacing: letterSpacing,
          fontSize: fontSize ?? type.size,
          fontStyle: fontStyle,
        );
    Widget widget = isNotAutoSize
        ? Text(
            title,
            style: style,
            maxLines: maxLines,
            overflow: overflow,
            textAlign: textAlign,
          )
        : AutoSizeText(
            title,
            style: style,
            maxLines: maxLines,
            overflow: overflow,
            textAlign: textAlign,
            minFontSize: type.size - 5,
          );
    if (line == TextLine.none) return widget;
    final lineWidget = Flexible(
      child: Container(
        height: heightLine,
        color: Colors.grey,
      ),
    );
    widget = Row(
      children: [
        if (line == TextLine.left || line == TextLine.both) ...[
          lineWidget,
          Gap(spaceLine),
        ],
        widget,
        if (line == TextLine.right || line == TextLine.both) ...[
          Gap(spaceLine),
          lineWidget,
        ],
      ],
    );
    return widget;
  }
}
