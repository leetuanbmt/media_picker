import '../../../../core/config.dart';
import '../../../../widgets/commons/button_custom.dart';
import 'user_name.dart';

class RegisterUserInformation extends HookConsumerWidget {
  const RegisterUserInformation({super.key, required this.onNextPage});
  final VoidCallback onNextPage;

  void registerInformation() {
    onNextPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.fontBoldLight,
    );

    final dropStyle = context.titleMedium!.copyWith(
      fontSize: 16.sp,
      color: AppTheme.blackBold,
      fontWeight: FontWeight.w300,
    );

    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppTheme.box,
      ),
      borderRadius: BorderRadius.circular(4.r),
    );

    final List<DropdownMenuEntry<String>> genders = [
      const DropdownMenuEntry(value: "Male", label: "Male"),
      const DropdownMenuEntry(value: "Female", label: "Female"),
      const DropdownMenuEntry(value: "Another", label: "Another"),
    ];

    // create a TextEditingController for each field
    final agencyCodeController = useTextEditingController();
    final firstNameController = useTextEditingController();
    final middleNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final anotherNameController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final genderController = useTextEditingController();
    final dateInputController = useTextEditingController(
      text: '選択する',
    );

    // create a ValueNotifier<bool> for each field
    final checkFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return firstNameController.text.isEmpty ||
          middleNameController.text.isEmpty ||
          lastNameController.text.isEmpty ||
          genderController.text.isEmpty ||
          phoneNumberController.text.isEmpty ||
          dateInputController.text == '選択する';
    }

    checkFieldsEmpty.value = areFieldsEmpty();

    Logger.log("checkFieldsEmpty.value ${checkFieldsEmpty.value}");

    useEffect(
      () {
        void listener() {
          checkFieldsEmpty.value = areFieldsEmpty();
        }

        firstNameController.addListener(listener);
        middleNameController.addListener(listener);
        lastNameController.addListener(listener);
        genderController.addListener(listener);
        dateInputController.addListener(listener);
        phoneNumberController.addListener(listener);
        return () {
          firstNameController.removeListener(listener);
          middleNameController.removeListener(listener);
          lastNameController.removeListener(listener);
          genderController.removeListener(listener);
          dateInputController.removeListener(listener);
          phoneNumberController.removeListener(listener);
        };
      },
      [],
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
            child: Text(
              '本人情報を入力してください',
              style: context.titleLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.blackBold,
              ),
            ),
          ),
          Wrap(
            runSpacing: 30.h,
            children: [
              InputInformation(
                title: '代理店コード（お持ちの方）',
                hintText: '0000000000',
                controller: agencyCodeController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputInformation(
                      title: "姓",
                      hintText: "(例)山田",
                      controller: firstNameController,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: InputInformation(
                      title: "姓",
                      hintText: "(例)太郎",
                      controller: middleNameController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputInformation(
                      title: "セイ",
                      hintText: "(例)ヤマダ",
                      controller: lastNameController,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: InputInformation(
                      title: "メイ",
                      hintText: "(例)タロウ",
                      controller: anotherNameController,
                    ),
                  ),
                ],
              ),
              InputInformation(
                title: "生年月日",
                hintText: "選択する",
                controller: dateInputController,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2050),
                  );
                  if (picked != null && picked != DateTime.now()) {
                    dateInputController.text =
                        DateFormat('yyyy年MM月dd日').format(picked);
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '性別',
                    style: style,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  DropdownMenu<String>(
                    hintText: '選択する',
                    textStyle: dropStyle,
                    width: 343.w,
                    controller: genderController,
                    inputDecorationTheme: InputDecorationTheme(
                      constraints: BoxConstraints(maxHeight: 57.h),
                      focusedBorder: border,
                      enabledBorder: border,
                      contentPadding: EdgeInsets.only(
                        left: 12.w,
                      ),
                      hintStyle: dropStyle,
                    ),
                    trailingIcon: const Icon(
                      color: AppTheme.icon,
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    dropdownMenuEntries: genders,
                    onSelected: (value) {
                      genderController.text = value!;
                    },
                  ),
                ],
              ),
              InputInformation(
                title: "電話番号",
                hintText: "09011112222",
                controller: phoneNumberController,
              ),
            ],
          ),
          SizedBox(
            height: 32.17.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return ButtonCustom(
                    "次へ",
                    width: 162.w,
                    height: 48.h,
                    backgroundColor: checkFieldsEmpty.value
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      checkFieldsEmpty.value ? null : registerInformation();
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
