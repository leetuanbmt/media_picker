import 'package:flutter/services.dart';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

class InputOTP extends StatelessWidget {
  const InputOTP({
    super.key,
    this.finalValue = false,
    this.textController,
  });

  final bool? finalValue;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: AppTheme.primaryColor,
      ),
      borderRadius: BorderRadius.circular(4),
    );
    return SizedBox(
      height: 50.h,
      width: 42.w,
      child: TextField(
        controller: textController,
        style: context.titleMedium!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1) {
            finalValue!
                ? showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: Assets.iconsIconLoading.svg(
                          height: 48.h,
                          width: 48.w,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  )
                : FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: border,
          enabledBorder: border.copyWith(
            borderSide: const BorderSide(color: AppTheme.box),
          ),
        ),
      ),
    );
  }
}
