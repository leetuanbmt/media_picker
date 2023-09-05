import '../core/config.dart';
import '../gen/assets.gen.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.focusNode,
    this.onChanged,
  });
  final bool readOnly;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String val)? onChanged;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool showIconClose = false;
  @override
  void initState() {
    widget.controller?.addListener(() {
      showIconClose = widget.controller?.text.isNotEmptyAndNotNull ?? false;
    });
    super.initState();
  }

  void clear() {
    widget.controller?.clear();
    widget.onChanged?.call('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      margin: EdgeInsets.only(right: 16.w),
      child: TextField(
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'ユーザー名・IDで検索',
          filled: true,
          fillColor: Colors.white,
          hintStyle: context.labelMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: AppTheme.boxFont,
          ),
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 32.w,
            minHeight: 24.h,
          ),
          prefixIcon: Assets.iconsIconSearch.svg(
            fit: BoxFit.scaleDown,
            width: 24.r,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 32.w,
            minHeight: 12.h,
          ),
          suffixIcon: showIconClose
              ? IconButton(
                  onPressed: clear,
                  icon: Assets.iconsIconClose.svg(),
                )
              : null,
        ),
      ),
    );
  }
}
