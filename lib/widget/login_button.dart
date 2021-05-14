import 'package:flutter/material.dart';
import 'package:flutter_dilidili/util/color.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, this.title, this.enable, this.onPressed})
      : super(key: key);
  final String? title;
  final bool? enable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: enable! ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          title!,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
