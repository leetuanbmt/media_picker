import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

class LoginBySocialOrID extends StatefulWidget {
  const LoginBySocialOrID({super.key});

  @override
  State<LoginBySocialOrID> createState() => _LoginBySocialOrIDState();
}

class _LoginBySocialOrIDState extends State<LoginBySocialOrID> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SNSアカウントでログイン',
          style: context.bodyMedium!.copyWith(
            color: const Color(0xff332C2C),
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(95, 18, 95, 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.imagesTwitterIcon.image(
                  height: 48,
                  width: 48,
                  fit: BoxFit.contain,
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.imagesGoogleIcon.image(
                  height: 48,
                  width: 48,
                  fit: BoxFit.contain,
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.imagesFacebookIcon.image(
                  height: 48,
                  width: 48,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Face IDでログイン',
          style: context.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xff565656),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 20),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Assets.imagesFaceIdIcon.image(
              height: 54,
              width: 54,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
