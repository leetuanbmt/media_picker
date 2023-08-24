import 'package:flutter_svg/svg.dart';

import '../core/config.dart';
import '../gen/assets.gen.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    this.readOnly = false,
    this.onTap,
  });
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      margin: EdgeInsets.only(right: 16.w),
      child: TextField(
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: 'ユーザー名・IDで検索',
          filled: true,
          fillColor: Colors.white,
          hintStyle: context.labelMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: const Color(0xffAFAFAF),
          ),
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: SvgPicture.asset(
            Assets.iconsIconSearch.path,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
