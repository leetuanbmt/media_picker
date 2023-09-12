import '../../../../core/config.dart';
import '../../../../providers/register_provider.dart';
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

    final agencyCode = useTextEditingController(
      text: ref.read(registerProvider).agencyCode.value,
    );
    final surName = useTextEditingController(
      text: ref.read(registerProvider).firstName.value,
    );
    final middleName = useTextEditingController(
      text: ref.read(registerProvider).middleName.value,
    );
    final lastName = useTextEditingController(
      text: ref.read(registerProvider).lastName.value,
    );
    final anotherName = useTextEditingController(
      text: ref.read(registerProvider).anotherName.value,
    );
    final phoneNumber = useTextEditingController(
      text: ref.read(registerProvider).phoneNumber.value,
    );
    final dateinput = useTextEditingController(
      text: ref.read(registerProvider).birthday.value ?? '選択する',
    );
    final gender = useTextEditingController(
      text: ref.read(registerProvider).gender.value,
    );

    final List<DropdownMenuEntry<String>> genders = [
      const DropdownMenuEntry(value: "Male", label: "Male"),
      const DropdownMenuEntry(value: "Female", label: "Female"),
      const DropdownMenuEntry(value: "Another", label: "Another"),
    ];

    final updateSurName = useValueListenable(surName);
    final updateMiddleName = useValueListenable(middleName);
    final updateLastName = useValueListenable(lastName);
    final updatePhoneNumber = useValueListenable(phoneNumber);
    final updateDateInput = useValueListenable(dateinput);
    final updateGender = useValueListenable(gender);

    void registerInformation() {
      ref.watch(registerProvider).getInformation(
            updateSurName.text,
            updateMiddleName.text,
            updateLastName.text,
            updatePhoneNumber.text,
            updateDateInput.text,
            updateGender.text,
            anotherName.text,
            agencyCode.text,
          );
      onNextPage();
    }

    return Consumer(
      builder: (context, ref, _) {
        bool isActiveButton = ref.watch(registerProvider).isValidInformation(
              updateSurName.text,
              updateMiddleName.text,
              updateLastName.text,
              updatePhoneNumber.text,
              updateGender.text,
              dateinput.text,
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
                    controller: dateinput,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2050),
                      );
                      if (picked != null && picked != DateTime.now()) {
                        dateinput.text =
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
                    backgroundColor: isActiveButton
                        ? AppTheme.primaryColor
                        : AppTheme.middleGray,
                    onPressed: () {
                      isActiveButton ? registerInformation() : null;
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
