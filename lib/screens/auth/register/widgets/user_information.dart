import '../../../../core/config.dart';
import '../../../../providers/auth/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import 'user_name.dart';

class RegisterUserInformation extends ConsumerWidget {
  const RegisterUserInformation({super.key, required this.onNextPage});
  final VoidCallback onNextPage;

  void registerInformation() {
    onNextPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(registerProvider.notifier);

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
      const DropdownMenuEntry(value: 'Male', label: 'Male'),
      const DropdownMenuEntry(value: 'Female', label: 'Female'),
      const DropdownMenuEntry(value: 'Another', label: 'Another'),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
            child: Text(
              context.tr(LocaleKeys.enterYourPersonalInformation),
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
                title: context.tr(LocaleKeys.agencyCode),
                hintText: '0000000000',
                controller: provider.agencyCodeController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputInformation(
                      title: context.tr(LocaleKeys.surname),
                      hintText: '(${context.tr(LocaleKeys.example)})山田',
                      controller: provider.firstNameController,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: InputInformation(
                      title: context.tr(LocaleKeys.surname),
                      hintText: '(${context.tr(LocaleKeys.example)})太郎',
                      controller: provider.middleNameController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputInformation(
                      title: context.tr(LocaleKeys.name),
                      hintText: '(${context.tr(LocaleKeys.example)})ヤマダ',
                      controller: provider.lastNameController,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: InputInformation(
                      title: context.tr(LocaleKeys.may),
                      hintText: '(${context.tr(LocaleKeys.example)})タロウ',
                      controller: provider.anotherNameController,
                    ),
                  ),
                ],
              ),
              InputInformation(
                title: context.tr(LocaleKeys.dateOfBirth),
                hintText: context.tr(LocaleKeys.select),
                controller: provider.dateInputController,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2050),
                  );
                  if (picked != null && picked != DateTime.now()) {
                    provider.dateInputController.text =
                        DateFormat('yyyy年MM月dd日').format(picked);
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(LocaleKeys.gender),
                    style: style,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  DropdownMenu<String>(
                    hintText: context.tr(LocaleKeys.select),
                    textStyle: dropStyle,
                    width: 343.w,
                    controller: provider.genderController,
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
                      provider.genderController.text = value!;
                    },
                  ),
                ],
              ),
              InputInformation(
                title: context.tr(LocaleKeys.telephoneNumber),
                hintText: '09011112222',
                controller: provider.phoneNumberController,
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
                  final isDisableButton = ref.watch(
                    registerProvider
                        .select((value) => value.checkInformationEmpty),
                  );
                  return ButtonCustom(
                    context.tr(LocaleKeys.toTheNext),
                    width: 162.w,
                    height: 48.h,
                    backgroundColor: isDisableButton
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {
                      if (isDisableButton) return;
                      onNextPage();
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
