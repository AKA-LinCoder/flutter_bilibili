import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;
  const LoginButton(
      {Key? key,
      required this.title,
      this.enable = true,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///填满整个宽度
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
