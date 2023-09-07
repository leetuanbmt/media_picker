import '../../../../core/config.dart';
import '../../../../widgets/commons/button_custom.dart';
import 'information.dart';

class RegisterUserInformation extends HookWidget {
  const RegisterUserInformation({super.key, required this.registerUsername});

  final bool registerUsername;

  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.fontBoldLight,
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
    final name = useTextEditingController();
    final anotherName = useTextEditingController();
    final phoneNumber = useTextEditingController();
    final dateinput = useTextEditingController(text: '選択する');

    final List<String> genders = ['Male', 'Female', 'Another'];
    final selectedGender = useState<String?>(null);

    final checkFieldEmpty = useState<bool>(true);
    final registerUsername = useState<bool>(false);

    bool areFieldsEmpty() {
      return surName.text.isEmpty ||
          middleName.text.isEmpty ||
          name.text.isEmpty ||
          phoneNumber.text.isEmpty;
    }

    useEffect(() {
      surName.addListener(() {
        checkFieldEmpty.value = areFieldsEmpty();
      });
      middleName.addListener(() {
        checkFieldEmpty.value = areFieldsEmpty();
      });
      name.addListener(() {
        checkFieldEmpty.value = areFieldsEmpty();
      });
      phoneNumber.addListener(() {
        checkFieldEmpty.value = areFieldsEmpty();
      });
      return null;
    });
    return registerUsername.value == false
        ? Column(
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
                          controller: name,
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
                      DropdownButtonFormField<String>(
                        value: selectedGender.value,
                        hint: Text(
                          '選択する',
                          style: context.titleMedium!.copyWith(
                            fontSize: 16.sp,
                            color: AppTheme.blackBold,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        style: context.titleMedium!.copyWith(
                          fontSize: 16.sp,
                          color: AppTheme.blackBold,
                          fontWeight: FontWeight.w300,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.icon,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10.w),
                          enabledBorder: border,
                          focusedBorder: border,
                        ),
                        onChanged: (item) {
                          selectedGender.value = item;
                        },
                        items: genders.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
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
                    backgroundColor: (checkFieldEmpty.value ||
                            selectedGender.value == null ||
                            dateinput.text == '選択する')
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      (checkFieldEmpty.value ||
                              selectedGender.value == null ||
                              dateinput.text == '選択する')
                          ? null
                          : registerUsername.value = true;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          )
        : const SizedBox();
  }
}
