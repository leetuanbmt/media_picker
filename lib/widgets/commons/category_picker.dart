import '../../core/config.dart';
import '../../core/models/models.dart';
import '../dialogs.dart';
import 'button_custom.dart';

class CategoryPicker extends HookWidget {
  const CategoryPicker({
    super.key,
    this.onChange,
    this.active = const [],
  });
  final List<String> active;
  final ValueChanged<List<String>>? onChange;
  static show(
    BuildContext context, {
    ValueChanged<List<String>>? onChange,
    List<String> active = const [],
  }) {
    return AppDialog.showAppBottomSheet(
      context,
      title: 'カテゴリーの変更',
      child: CategoryPicker(
        onChange: onChange,
        active: active,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cateNotify = useValueNotifier([...active]);
    final categories = useListenable(cateNotify);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.w,
          runSpacing: 12.h,
          children: UserModel.listCategory
              .map(
                (e) => ButtonCustom(
                  e,
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
                  textColor: categories.value.contains(e) ? Colors.white : null,
                  borderWidth: 2.w,
                  padding: EdgeInsets.all(10.r),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 30.h),
        ButtonCustom(
          '設定する',
          height: 48.h,
          width: context.screenWidth,
          onPressed: () {
            Navigator.of(context).pop();
            onChange?.call(categories.value);
          },
        ),
      ],
    );
  }
}
