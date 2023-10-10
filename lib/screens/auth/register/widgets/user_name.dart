import '../../../../core/config.dart';

import '../../../../providers/auth/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterUserName extends ConsumerWidget {
  const RegisterUserName({super.key, required this.onNextPage});
  final VoidCallback onNextPage;

  void confirmUsername(BuildContext context) {
    FocusScope.of(context).unfocus();
    onNextPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register = ref.read(registerProvider.notifier);

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
            textController: register.userNameController,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final isDisableButton = ref.watch(
                    registerProvider
                        .select((value) => value.checkUsernameEmpty),
                  );
                  return ButtonCustom(
                    "次へ",
                    height: 48.h,
                    width: 162.w,
                    backgroundColor: isDisableButton
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      isDisableButton ? null : confirmUsername(context);
                    },
                  );
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
