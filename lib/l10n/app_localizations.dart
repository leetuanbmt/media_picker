import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('vi')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @myPage.
  ///
  /// In en, this message translates to:
  /// **'My Page'**
  String get myPage;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japanese;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @externLink.
  ///
  /// In en, this message translates to:
  /// **'External Link'**
  String get externLink;

  /// No description provided for @selfIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Self Introduction'**
  String get selfIntroduction;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @themeColor.
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get themeColor;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @release.
  ///
  /// In en, this message translates to:
  /// **'Release'**
  String get release;

  /// No description provided for @checkPoints.
  ///
  /// In en, this message translates to:
  /// **'Check Points'**
  String get checkPoints;

  /// No description provided for @paymentSettings.
  ///
  /// In en, this message translates to:
  /// **'Payment Settings'**
  String get paymentSettings;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @usageGuide.
  ///
  /// In en, this message translates to:
  /// **'Usage Guide'**
  String get usageGuide;

  /// No description provided for @announcementDistribution.
  ///
  /// In en, this message translates to:
  /// **'Announcement of distribution schedule'**
  String get announcementDistribution;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @becomeCreator.
  ///
  /// In en, this message translates to:
  /// **'Become Creator'**
  String get becomeCreator;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettings;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @earnedPoints.
  ///
  /// In en, this message translates to:
  /// **'Earned Points'**
  String get earnedPoints;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @incomingCall.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call'**
  String get incomingCall;

  /// No description provided for @calling.
  ///
  /// In en, this message translates to:
  /// **'Calling'**
  String get calling;

  /// No description provided for @callEnd.
  ///
  /// In en, this message translates to:
  /// **'Call End'**
  String get callEnd;

  /// No description provided for @callReject.
  ///
  /// In en, this message translates to:
  /// **'Call Reject'**
  String get callReject;

  /// No description provided for @callFailed.
  ///
  /// In en, this message translates to:
  /// **'Call Failed'**
  String get callFailed;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get connecting;

  /// No description provided for @searchByUser.
  ///
  /// In en, this message translates to:
  /// **'Search by user name/ID'**
  String get searchByUser;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get seeMore;

  /// No description provided for @toFollow.
  ///
  /// In en, this message translates to:
  /// **'To follow'**
  String get toFollow;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

  /// No description provided for @searchByCategory.
  ///
  /// In en, this message translates to:
  /// **'Search by category'**
  String get searchByCategory;

  /// No description provided for @callHistory.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistory;

  /// No description provided for @noCallHistory.
  ///
  /// In en, this message translates to:
  /// **'No call history'**
  String get noCallHistory;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @ranking.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get ranking;

  /// No description provided for @pointEarned.
  ///
  /// In en, this message translates to:
  /// **'Point Earned'**
  String get pointEarned;

  /// No description provided for @convertToTipPoints.
  ///
  /// In en, this message translates to:
  /// **'Convert to Tip Points'**
  String get convertToTipPoints;

  /// No description provided for @chipHistory.
  ///
  /// In en, this message translates to:
  /// **'Chip History'**
  String get chipHistory;

  /// No description provided for @purchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get purchaseHistory;

  /// No description provided for @transferHistory.
  ///
  /// In en, this message translates to:
  /// **'Transfer History'**
  String get transferHistory;

  /// No description provided for @toDay.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get toDay;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @usageFlow.
  ///
  /// In en, this message translates to:
  /// **'Usage Flow'**
  String get usageFlow;

  /// No description provided for @howToPlayGuide.
  ///
  /// In en, this message translates to:
  /// **'How to play guide'**
  String get howToPlayGuide;

  /// No description provided for @inquiry.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get inquiry;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @fan.
  ///
  /// In en, this message translates to:
  /// **'Fan'**
  String get fan;

  /// No description provided for @enjoyAs.
  ///
  /// In en, this message translates to:
  /// **'Enjoy as'**
  String get enjoyAs;

  /// No description provided for @connectDevices.
  ///
  /// In en, this message translates to:
  /// **'Connect devices'**
  String get connectDevices;

  /// No description provided for @callTheFans.
  ///
  /// In en, this message translates to:
  /// **'Call the fans'**
  String get callTheFans;

  /// No description provided for @getATip.
  ///
  /// In en, this message translates to:
  /// **'Get a tip'**
  String get getATip;

  /// No description provided for @tipsToEarnPoints.
  ///
  /// In en, this message translates to:
  /// **'Tips to earn points'**
  String get tipsToEarnPoints;

  /// No description provided for @controlRequest.
  ///
  /// In en, this message translates to:
  /// **'Control request'**
  String get controlRequest;

  /// No description provided for @convertTipDescription.
  ///
  /// In en, this message translates to:
  /// **'You can convert the earned points into chip points and use them for tipping.'**
  String get convertTipDescription;

  /// No description provided for @buyPoints.
  ///
  /// In en, this message translates to:
  /// **'Buy points'**
  String get buyPoints;

  /// No description provided for @findCreators.
  ///
  /// In en, this message translates to:
  /// **'Find creators'**
  String get findCreators;

  /// No description provided for @donateMoney.
  ///
  /// In en, this message translates to:
  /// **'Donate money'**
  String get donateMoney;

  /// No description provided for @connectedDevices.
  ///
  /// In en, this message translates to:
  /// **'Connected devices'**
  String get connectedDevices;

  /// No description provided for @userRanking.
  ///
  /// In en, this message translates to:
  /// **'User ranking'**
  String get userRanking;

  /// No description provided for @inform.
  ///
  /// In en, this message translates to:
  /// **'Inform'**
  String get inform;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @keep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keep;

  /// No description provided for @sendPoints.
  ///
  /// In en, this message translates to:
  /// **'Send points'**
  String get sendPoints;

  /// No description provided for @reportUser.
  ///
  /// In en, this message translates to:
  /// **'Report user'**
  String get reportUser;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @userReports.
  ///
  /// In en, this message translates to:
  /// **'User reports'**
  String get userReports;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @reportViolationsByUser.
  ///
  /// In en, this message translates to:
  /// **'Report violations by users'**
  String get reportViolationsByUser;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @hasBlocked.
  ///
  /// In en, this message translates to:
  /// **'has been blocked'**
  String get hasBlocked;

  /// No description provided for @possessionPoints.
  ///
  /// In en, this message translates to:
  /// **'Possession points'**
  String get possessionPoints;

  /// No description provided for @charge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get charge;

  /// No description provided for @delaySetting.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get delaySetting;

  /// No description provided for @autoSetting.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get autoSetting;

  /// No description provided for @noteAboutDelaySetting.
  ///
  /// In en, this message translates to:
  /// **'Notes about delay settings go here.'**
  String get noteAboutDelaySetting;

  /// No description provided for @noteAboutAutoSetting.
  ///
  /// In en, this message translates to:
  /// **'Notes about auto settings go here.'**
  String get noteAboutAutoSetting;

  /// No description provided for @set.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get set;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get saveSettings;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @untilReceivePoints.
  ///
  /// In en, this message translates to:
  /// **'Until you receive the points'**
  String get untilReceivePoints;

  /// No description provided for @after.
  ///
  /// In en, this message translates to:
  /// **'After'**
  String get after;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @underControl.
  ///
  /// In en, this message translates to:
  /// **'Under control'**
  String get underControl;

  /// No description provided for @addEquipment.
  ///
  /// In en, this message translates to:
  /// **'Add equipment'**
  String get addEquipment;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @controlRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Control request sent'**
  String get controlRequestSent;

  /// No description provided for @controlRequestSettings.
  ///
  /// In en, this message translates to:
  /// **'Control request settings'**
  String get controlRequestSettings;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send request'**
  String get sendRequest;

  /// No description provided for @requesting.
  ///
  /// In en, this message translates to:
  /// **'Requesting'**
  String get requesting;

  /// No description provided for @requestRequires.
  ///
  /// In en, this message translates to:
  /// **'Request requires 10000 points or less'**
  String get requestRequires;

  /// No description provided for @spentAllPoint.
  ///
  /// In en, this message translates to:
  /// **'I spent all my points'**
  String get spentAllPoint;

  /// No description provided for @isControllingYourDevice.
  ///
  /// In en, this message translates to:
  /// **'is controlling your device'**
  String get isControllingYourDevice;

  /// No description provided for @confirmFinish.
  ///
  /// In en, this message translates to:
  /// **'I haven\'t used all my points.\nDo you want to finish?'**
  String get confirmFinish;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @remainingPoints.
  ///
  /// In en, this message translates to:
  /// **'Remaining points'**
  String get remainingPoints;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'people'**
  String get people;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password (6 or more alphanumeric characters)'**
  String get password;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @logInAutomaticallyNextTime.
  ///
  /// In en, this message translates to:
  /// **'Log in automatically from next time'**
  String get logInAutomaticallyNextTime;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get logIn;

  /// No description provided for @byStartingFromAbove.
  ///
  /// In en, this message translates to:
  /// **'By starting from above,'**
  String get byStartingFromAbove;

  /// No description provided for @iAgree.
  ///
  /// In en, this message translates to:
  /// **'I agree.'**
  String get iAgree;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t have an account '**
  String get doNotHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account '**
  String get alreadyHaveAccount;

  /// No description provided for @logInWithFaceID.
  ///
  /// In en, this message translates to:
  /// **'Log in with Face ID'**
  String get logInWithFaceID;

  /// No description provided for @logInWithYourSNSAccount.
  ///
  /// In en, this message translates to:
  /// **'Log in with your SNS account'**
  String get logInWithYourSNSAccount;

  /// No description provided for @enterYourPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Enter your personal information'**
  String get enterYourPersonalInformation;

  /// No description provided for @agencyCode.
  ///
  /// In en, this message translates to:
  /// **'Agency code (if you have one)'**
  String get agencyCode;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get example;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @telephoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Telephone number'**
  String get telephoneNumber;

  /// No description provided for @toTheNext.
  ///
  /// In en, this message translates to:
  /// **'To the next'**
  String get toTheNext;

  /// No description provided for @decideOnUsername.
  ///
  /// In en, this message translates to:
  /// **'Decide on username'**
  String get decideOnUsername;

  /// No description provided for @purposeUse.
  ///
  /// In en, this message translates to:
  /// **'Which purpose do you use it for?'**
  String get purposeUse;

  /// No description provided for @categoryAppliesToYou.
  ///
  /// In en, this message translates to:
  /// **'Category that applies to you'**
  String get categoryAppliesToYou;

  /// No description provided for @pleaseSelect.
  ///
  /// In en, this message translates to:
  /// **'Please select'**
  String get pleaseSelect;

  /// No description provided for @registerYourStripeAccount.
  ///
  /// In en, this message translates to:
  /// **'Register your Stripe account'**
  String get registerYourStripeAccount;

  /// No description provided for @registerAccountWithdrawPoint.
  ///
  /// In en, this message translates to:
  /// **'Register account can withdraw points you have earned.'**
  String get registerAccountWithdrawPoint;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @registerCompleted.
  ///
  /// In en, this message translates to:
  /// **'Registration has been completed!'**
  String get registerCompleted;

  /// No description provided for @selectUserAttributes.
  ///
  /// In en, this message translates to:
  /// **'Select user attributes'**
  String get selectUserAttributes;

  /// No description provided for @selectUserAttributesInform.
  ///
  /// In en, this message translates to:
  /// **'Whether you register as a creator or a fan, you can change your identity at any time.'**
  String get selectUserAttributesInform;

  /// No description provided for @startAsCreator.
  ///
  /// In en, this message translates to:
  /// **'Start as a creator'**
  String get startAsCreator;

  /// No description provided for @forDistributorsOrStores.
  ///
  /// In en, this message translates to:
  /// **'For distributors/stores'**
  String get forDistributorsOrStores;

  /// No description provided for @startAsFan.
  ///
  /// In en, this message translates to:
  /// **'Start as a fan'**
  String get startAsFan;

  /// No description provided for @personWhoTipsMoney.
  ///
  /// In en, this message translates to:
  /// **'Person who tips money'**
  String get personWhoTipsMoney;

  /// No description provided for @settingThemeColor.
  ///
  /// In en, this message translates to:
  /// **'Setting theme color'**
  String get settingThemeColor;

  /// No description provided for @noSearchResult.
  ///
  /// In en, this message translates to:
  /// **'There is no search result'**
  String get noSearchResult;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR code'**
  String get qrCode;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading...'**
  String get reading;

  /// No description provided for @connection_restored.
  ///
  /// In en, this message translates to:
  /// **'Internet connection has been restored'**
  String get connection_restored;

  /// No description provided for @you_are_offline.
  ///
  /// In en, this message translates to:
  /// **'You are currently offline'**
  String get you_are_offline;

  /// A message with a formatted int parameter
  ///
  /// In en, this message translates to:
  /// **'Number of data points: {value}'**
  String numberOfDataPoints(int value);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
