import '../../../core/config.dart';
import '../../../widgets/commons/button_custom.dart';

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
                return ButtonCustom(
                  "ログイン",
                  width: 327,
                  height: 48,
                  backgroundColor: _isButtonEnabled.value
                      ? AppTheme.primaryColor
                      : const Color(0xffC0C8CD),
                  onPressed: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
