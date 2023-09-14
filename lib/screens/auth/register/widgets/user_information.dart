import '../../../../core/config.dart';
import '../../../../widgets/commons/button_custom.dart';
import 'user_name.dart';

class RegisterUserInformation extends HookWidget {
  const RegisterUserInformation({super.key, required this.onNextPage});
  final VoidCallback onNextPage;

  void registerInformation() {
    onNextPage();
  }

  @override
  Widget build(BuildContext context) {
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

    final agencyCode = useTextEditingController();
    final surName = useTextEditingController();
    final middleName = useTextEditingController();
    final lastName = useTextEditingController();
    final anotherName = useTextEditingController();
    final phoneNumber = useTextEditingController();
    final dateInput = useTextEditingController(
      text: '選択する',
    );
    final gender = useTextEditingController();

    final List<DropdownMenuEntry<String>> genders = [
      const DropdownMenuEntry(value: "Male", label: "Male"),
      const DropdownMenuEntry(value: "Female", label: "Female"),
      const DropdownMenuEntry(value: "Another", label: "Another"),
    ];

    useEffect(
      () {
        agencyCode.text;
        return () {};
      },
      [
        agencyCode.text,
        surName.value,
        middleName.value,
        lastName.value,
        anotherName.value,
        phoneNumber.value,
        dateInput.value,
        gender.value,
      ],
    );

    return HookBuilder(
      builder: (context) {
        final updateSurName = useValueListenable(surName);
        final updateMiddleName = useValueListenable(middleName);
        final updateLastName = useValueListenable(lastName);
        final updatePhoneNumber = useValueListenable(phoneNumber);
        final updateDateInput = useValueListenable(dateInput);
        final updateGender = useValueListenable(gender);

        final isActiveButton = useState<bool>(true);

        if (updateSurName.text.isNotEmpty &&
            updateMiddleName.text.isNotEmpty &&
            updateLastName.text.isNotEmpty &&
            updatePhoneNumber.text.isNotEmpty &&
            updateGender.text.isNotEmpty &&
            updateDateInput.text != '選択する') {
          isActiveButton.value = true;
        } else {
          isActiveButton.value = false;
        }

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
                    controller: agencyCode,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputInformation(
                          title: "姓",
                          hintText: "(例)山田",
                          controller: surName,
                        ),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Expanded(
                        child: InputInformation(
                          title: "姓",
                          hintText: "(例)太郎",
                          controller: middleName,
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
                          controller: lastName,
                        ),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Expanded(
                        child: InputInformation(
                          title: "メイ",
                          hintText: "(例)タロウ",
                          controller: anotherName,
                        ),
                      ),
                    ],
                  ),
                  InputInformation(
                    title: "生年月日",
                    hintText: "選択する",
                    controller: dateInput,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2050),
                      );
                      if (picked != null && picked != DateTime.now()) {
                        dateInput.text =
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
                        controller: gender,
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
                          gender.text = value!;
                        },
                      ),
                    ],
                  ),
                  InputInformation(
                    title: "電話番号",
                    hintText: "09011112222",
                    controller: phoneNumber,
                  ),
                ],
              ),
              SizedBox(
                height: 32.17.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonCustom(
                    "次へ",
                    width: 162.w,
                    height: 48.h,
                    backgroundColor: isActiveButton.value
                        ? AppTheme.primaryColor
                        : AppTheme.middleGray,
                    onPressed: () {
                      isActiveButton.value ? registerInformation() : null;
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
      },
    );
  }
}
