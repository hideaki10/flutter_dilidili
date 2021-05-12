import 'package:flutter/material.dart';
import 'package:flutter_dilidili/widget/appbar.dart';
import 'package:flutter_dilidili/widget/login_effect.dart';
import 'package:flutter_dilidili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumptoLogin;

  const RegistrationPage({Key? key, this.onJumptoLogin}) : super(key: key);

  @override
  _RegiState createState() => _RegiState();
}

class _RegiState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("register", "login", () {
        print("right button click");
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              hint: 'input you name',
              title: 'user',
              onChanged: (text) {
                print(text);
              },
              focusChanged: (focus) {},
            ),
            LoginInput(
              hint: 'input you password',
              title: 'user',
              onChanged: (text) {
                print(text);
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
