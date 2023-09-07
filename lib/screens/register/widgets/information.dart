import '../../../core/config.dart';
import '../../../widgets/commons/button_custom.dart';
import '../../../widgets/commons/text_field_custom.dart';
import '../select_attribute_screen.dart';
import 'user_information.dart';

class RegisterInformationScreen extends HookWidget {
  const RegisterInformationScreen({super.key, required this.onNextPage});
  final Function onNextPage;

  @override
  Widget build(BuildContext context) {
    final userNameController = useTextEditingController();
    final checkFieldEmpty1 = useState<bool>(true);

    useEffect(() {
      userNameController.addListener(() {
        checkFieldEmpty1.value = userNameController.text.isEmpty;
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
                    backgroundColor: checkFieldEmpty1.value
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      checkFieldEmpty1.value ? null : onNextPage();
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
