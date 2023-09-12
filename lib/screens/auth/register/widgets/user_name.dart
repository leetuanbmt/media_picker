import '../../../../core/config.dart';

import '../../../../providers/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterUserName extends HookConsumerWidget {
  const RegisterUserName({super.key, required this.onNextPage});
  final VoidCallback onNextPage;

  void confirmUsername(BuildContext context, WidgetRef ref, String userName) {
    ref.watch(registerProvider).changeUserName(userName);
    FocusScope.of(context).unfocus();
    onNextPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController(
      text: ref.read(registerProvider).userName.value,
    );

    final checkFieldEmpty = useState<bool>(true);

    final updateUserName = useValueListenable(userNameController);

    bool isFieldEmpty() {
      return updateUserName.text.isEmpty;
    }

    checkFieldEmpty.value = isFieldEmpty();

    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32.h,
              ),
              Text(
                'ユーザー名を決定しましょう',
                style: context.titleLarge!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.blackBold,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              TextFieldCustom(
                hintText: 'ユーザー名',
                textController: userNameController,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonCustom(
                    "次へ",
                    height: 48.h,
                    width: 162.w,
                    backgroundColor: checkFieldEmpty.value
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      checkFieldEmpty.value
                          ? null
                          : confirmUsername(context, ref, updateUserName.text);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 27.h,
              ),
            ],
          ),
        );
      },
    );
  }
}

class InputInformation extends StatelessWidget {
  const InputInformation({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.onTap,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.fontBoldLight,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: style,
        ),
        SizedBox(height: 7.h),
        TextFieldCustom(
          hintText: hintText,
          readOnly: onTap != null,
          suffixIcon: onTap != null
              ? const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.icon,
                )
              : null,
          textController: controller,
          onTap: onTap,
        ),
      ],
    );
  }
}
