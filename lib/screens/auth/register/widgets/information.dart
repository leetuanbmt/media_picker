import '../../../../core/config.dart';
import '../../../../core/models/enum/enum.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';
import '../select_attribute_screen.dart';
import 'user_information.dart';

class RegisterInformationScreen extends HookWidget {
  const RegisterInformationScreen({super.key, required this.onNextPage});
  final Function onNextPage;

  @override
  Widget build(BuildContext context) {
    final userNameController = useTextEditingController();
    final checkFieldEmpty = useState<bool>(true);

    useEffect(() {
      userNameController.addListener(() {
        checkFieldEmpty.value = userNameController.text.isEmpty;
      });
      return null;
    });

    final registerUsername = useState<bool>(false);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          Column(
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
              SizedBox(
                height: 496.h,
              ),
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
                      checkFieldEmpty.value ? null : onNextPage();
                    },
                  ),
                ],
              ),
            ],
          ),
          if (SelectAttributeScreen.userType == UserType.creator)
            ColoredBox(
              color: Colors.white,
              child: RegisterUserInformation(
                registerUsername: registerUsername.value,
              ),
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
