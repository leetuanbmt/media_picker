import '../../core/config.dart';
import '../../core/providers/firebase_provider.dart';
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
    final selects = useState<List<String>>([...active]);
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(categoriesProvider).maybeWhen(
              orElse: () => Dimensions.empty,
              data: (categories) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 12.h,
                    children: categories
                        .map(
                          (e) => ButtonCustom(
                            e,
                            onPressed: () {
                              if (selects.value.contains(e)) {
                                selects.value = [...selects.value..remove(e)];
                              } else {
                                selects.value = [...selects.value..add(e)];
                              }
                            },
                            type: selects.value.contains(e)
                                ? ButtonType.normal
                                : ButtonType.outline,
                            textColor:
                                selects.value.contains(e) ? Colors.white : null,
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
                      onChange?.call(categories);
                    },
                  ),
                ],
              ),
            );
      },
    );
  }
}
