import '../../../core/config.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/commons/button_custom.dart';

class LanguageScreen extends HookConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultLanguage = useState(AppLanguage.currentLanguage);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(context.tr(LocaleKeys.language)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: AppLanguage.supportLanguage.length,
                itemBuilder: (BuildContext context, int index) {
                  final language = AppLanguage.supportLanguage[index];
                  return ListTile(
                    title: Text(
                      context.tr(language.value),
                      style: context.bodyLarge,
                    ),
                    trailing: language.locale == defaultLanguage.value
                        ? Icon(
                            Icons.check,
                            color: AppTheme.primaryColor,
                          )
                        : null,
                    onTap: () {
                      defaultLanguage.value = language.locale;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: ButtonCustom(
                context.tr(LocaleKeys.save),
                width: double.infinity,
                height: 44.h,
                onPressed: () {
                  final locale = defaultLanguage.value;
                  AppLanguage.changeLanguage(context, locale);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
