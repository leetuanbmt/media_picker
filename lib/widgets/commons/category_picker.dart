import '../../core/config.dart';
import '../../core/models/models.dart';
import '../../providers/category_provider.dart';
import '../dialogs.dart';
import 'button_custom.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({super.key});
  static show(BuildContext context) {
    return AppDialog.showAppBottomSheet(
      context,
      title: 'カテゴリーの変更',
      child: const CategoryPicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer(
          builder: (context, ref, _) {
            final category = ref.watch(categoryProvider);
            Logger.log(category);
            return Wrap(
              spacing: 4.w,
              runSpacing: 12.h,
              children: UserModel.listCategory
                  .map(
                    (e) => ButtonCustom(
                      e,
                      onPressed: () {
                        if (category.contains(e)) {
                          ref
                              .read(categoryProvider.notifier)
                              .update((state) => [...state..remove(e)]);
                        } else {
                          ref
                              .read(categoryProvider.notifier)
                              .update((state) => [...state, e]);
                        }
                      },
                      type: category.contains(e)
                          ? ButtonType.normal
                          : ButtonType.outline,
                      textColor: category.contains(e) ? Colors.white : null,
                      borderWidth: 2.w,
                      padding: EdgeInsets.all(10.r),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        SizedBox(height: 30.h),
        ButtonCustom(
          '設定する',
          height: 48.h,
          width: context.screenWidth,
          onPressed: () {
            Navigator.of(context).pop();

            /// return list category
          },
        ),
      ],
    );
  }
}
