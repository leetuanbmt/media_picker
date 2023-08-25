import 'package:flutter/gestures.dart';

import '../core/config.dart';
import '../gen/assets.gen.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 37,
                    bottom: 30,
                  ),
                  child: Assets.imagesLoginScreenLogo.image(
                    height: 109,
                    width: 78,
                    fit: BoxFit.contain,
                  ),
                ),
                const LoginForm(),
                const LoginBySocial(),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '上記からはじめることで、',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: const Color(0xff646464),
                        ),
                      ),
                      TextSpan(
                        text: '利用規約',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: 'に同意します。',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: const Color(0xff646464),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 37),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'アカウントをお持ちでない方',
                          style: context.bodyMedium!.copyWith(
                            fontSize: 12,
                            color: const Color(0xff646464),
                          ),
                        ),
                        TextSpan(
                          text: '新規登録',
                          style: context.bodyMedium!.copyWith(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isChecked = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _emailController.addListener(_checkInputValue);
    _passwordController.addListener(_checkInputValue);
  }

  void _checkInputValue() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _isButtonEnabled.value = true;
    } else {
      _isButtonEnabled.value = false;
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_checkInputValue);
    _passwordController.removeListener(_checkInputValue);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 45),
      child: SizedBox(
        height: 216,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                style: context.bodyLarge!.copyWith(
                  fontSize: 16,
                  color: const Color(0xff332C2C),
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  hintText: 'メールアドレス',
                  hintStyle: context.bodyLarge!.copyWith(
                    color: const Color(0xff95A8B5),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 14, 0, 14),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffD4D4D4),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffD4D4D4),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  border: InputBorder.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  controller: _passwordController,
                  style: context.titleMedium!.copyWith(
                    fontSize: 24,
                    color: const Color(0xff332C2C),
                    fontWeight: FontWeight.w300,
                  ),
                  obscureText: true,
                  obscuringCharacter: '●',
                  decoration: InputDecoration(
                    hintText: 'パスワード（6文字以上の半角英数字）',
                    hintStyle: context.bodyLarge!.copyWith(
                      fontSize: 16,
                      color: const Color(0xff95A8B5),
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 8, 0, 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffD4D4D4),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffD4D4D4),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    side: const BorderSide(
                      color: Color(0xffD4D4D4),
                      width: 3,
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    '次回から自動でログイン',
                    style: context.bodySmall!.copyWith(
                      color: const Color(0xff646464),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _isButtonEnabled,
                builder: (context, validate, _) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled.value
                          ? AppTheme.primaryColor
                          : const Color(0xffC0C8CD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fixedSize: const Size(372, 48),
                    ),
                    child: Text(
                      'ログイン',
                      style: context.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffFFF9FF),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginBySocial extends StatefulWidget {
  const LoginBySocial({super.key});

  @override
  State<LoginBySocial> createState() => _LoginBySocialState();
}

class _LoginBySocialState extends State<LoginBySocial> {
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
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.imagesGoogleIcon.image(
                  height: 48,
                  width: 48,
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.imagesFacebookIcon.image(
                  height: 48,
                  width: 48,
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
            child: SizedBox.square(
              dimension: 54,
              child: Assets.imagesFaceIdIcon.image(),
            ),
          ),
        ),
      ],
    );
  }
}
