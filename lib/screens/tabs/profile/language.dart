import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config.dart';
import '../../../core/providers/user_preferences/user_preferences_provider.dart';
import '../../../widgets/commons/button_custom.dart';

@RoutePage()
class LanguageScreen extends HookConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(UserPreferencesNotifier.provider);
    final preferencesNotifier = ref.watch(UserPreferencesNotifier.notifier);
    final defaultLanguage = useState(preferences.locale);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(context.lang.language),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: AppLocalizations.supportedLocales.length,
                itemBuilder: (BuildContext context, int index) {
                  final language = AppLocalizations.supportedLocales[index];
                  final isoCodeName = LanguageLocals.getDisplayLanguage(
                    language.languageCode,
                  );
                  return ListTile(
                    title: Text(
                      '${isoCodeName.name} (${isoCodeName.nativeName})',
                      style: context.bodyLarge,
                    ),
                    trailing: language == defaultLanguage.value
                        ? Icon(
                            Icons.check,
                            color: context.primaryColor,
                          )
                        : null,
                    onTap: () {
                      defaultLanguage.value = language;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: ButtonCustom(
                context.lang.save,
                width: double.infinity,
                height: 44.h,
                onPressed: () {
                  final locale = defaultLanguage.value;
                  preferencesNotifier.setLocale(locale);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
