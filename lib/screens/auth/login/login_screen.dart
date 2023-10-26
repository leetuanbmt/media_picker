import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../providers/auth/auth_notify.dart';
import '../../../routes/app_routes.gr.dart';
import '../widgets/logo.dart';
import '../widgets/social_button.dart';
import 'widgets/login_form.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.onResult});
  final Function(bool didLogin)? onResult;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.endOfFrame.then((value) => checkUserInJapan());
    super.initState();
  }

  void checkUserInJapan() {
    Logger.log('checkUserInJapan');
    isUserInJapan().then(
      (isInJapan) {
        if (!isInJapan) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Location Restriction'),
                content: const Text('Login is only available in Japan.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      onError: (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Location Restriction'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<bool> isUserInJapan() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }

      // Use a geo location library like 'geolocator' to get the user's location
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      Logger.log(position.toJson());
      // Implement your logic to determine if the user is in Japan based on their location
      // For simplicity, let's assume that if the latitude is between 24 and 46 (roughly Japan's latitudinal range),
      // we consider the user to be in Japan
      return position.latitude >= 24 && position.latitude <= 46;
    } catch (e) {
      Logger.log("error: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const AuthLogo(),
              const LoginForm(),
              Consumer(
                builder: (context, ref, child) {
                  final auth = ref.read(authProvider.notifier);
                  return SocialList(
                    loginGoogle: auth.loginGoogle,
                    loginFacebook: auth.loginFacebook,
                    loginTwitter: auth.loginTwitter,
                    loginApple: auth.loginApple,
                  );
                },
              ),
              // ButtonCustom(
              //   'Text',
              //   onPressed: () async {
              //     context.startLoading();
              //     // const address = "Microsoft Building 25 Redmond WA USA";
              //     // final locations = await locationFromAddress(address);
              //     final currentPosition = await Geolocator.getCurrentPosition(
              //       desiredAccuracy: LocationAccuracy.high,
              //     );
              //     final Location location = Location(
              //       latitude: currentPosition.latitude,
              //       longitude: currentPosition.longitude,
              //       timestamp: DateTime.now(),
              //     );
              //     final List<Placemark> placemarks =
              //         await placemarkFromCoordinates(
              //       location.latitude,
              //       location.longitude,
              //       localeIdentifier: 'en_US',
              //     );
              //     // full address is stored in placemark
              //     String? address;
              //  address =
              //           '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
              //     if (placemarks.isNotEmpty) {
              //       final Placemark placemark = placemarks[0];
              //       if (placemark.street.isNotEmptyAndNotNull) {
              //         address = placemark.street;
              //       }
              //       if (placemark.subAdministrativeArea.isNotEmptyAndNotNull) {
              //         address = '$address, ${placemark.subAdministrativeArea}';
              //       }
              //       if (placemark.administrativeArea.isNotEmptyAndNotNull) {
              //         address = '$address, ${placemark.administrativeArea}';
              //       }

              //       if (placemark.country.isNotEmptyAndNotNull) {
              //         address = '$address, ${placemark.country}';
              //       }
              //     }
              //     if (mounted) context.endLoading();
              //     Logger.log(address);
              //   },
              // ),
              const LoginByFaceID(),
              const LoginInformation(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginInformation extends StatelessWidget {
  const LoginInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.bodySmall!.copyWith(
      color: AppTheme.fontGrayLead,
    );
    return Column(
      children: [
        HeightBox(30.h),
        RichText(
          text: TextSpan(
            style: style,
            children: <TextSpan>[
              TextSpan(
                text: context.tr(LocaleKeys.byStartingFromAbove),
                // style: style,
              ),
              TextSpan(
                text: context.tr(LocaleKeys.termsOfService),
                style: style.copyWith(color: AppTheme.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              TextSpan(
                text: context.tr(LocaleKeys.IAgree),
                // style: style,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: context.tr(LocaleKeys.doNotHaveAccount),
                style: style,
              ),
              TextSpan(
                text: context.tr(LocaleKeys.signUp),
                style: style.copyWith(color: AppTheme.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.router.replace(const RegisterRoute());
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginByFaceID extends ConsumerWidget {
  const LoginByFaceID({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          context.tr(LocaleKeys.logInWithFaceID),
          style: context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.fontBoldLight,
          ),
        ),
        SizedBox(height: 10.h),
        IconButton(
          icon: Assets.iconsIconFaceId.svg(),
          onPressed: () {},
        ),
      ],
    );
  }
}
