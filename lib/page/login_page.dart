import 'package:flutter/material.dart';
import 'package:flutter_dilidili/http/core/hi_error.dart';
import 'package:flutter_dilidili/http/dao/login_dao.dart';
import 'package:flutter_dilidili/util/string_util.dart';
import 'package:flutter_dilidili/util/toast.dart';
import 'package:flutter_dilidili/widget/appbar.dart';
import 'package:flutter_dilidili/widget/login_button.dart';
import 'package:flutter_dilidili/widget/login_effect.dart';
import 'package:flutter_dilidili/widget/login_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('mima', 'zhuche', () {}),
      body: Container(
        child: ListView(
          children: <Widget>[
            LoginEffect(protect: protect),
            LoginInput(
              title: 'user',
              hint: 'please input you name',
              onChanged: (String text) {
                userName = text;
              },
              focusChanged: (_) {},
            ),
            LoginInput(
              title: 'password',
              hint: 'please input you password',
              onChanged: (String text) {
                password = text;
                checkInput();
              },
              focusChanged: (bool focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                title: 'zhuche',
                enable: loginEable,
                onPressed: send,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool _enable;
    if (isNotEmpty(userName!) && isNotEmpty(password!)) {
      _enable = true;
    } else {
      _enable = false;
    }
    setState(() {
      loginEable = _enable;
    });
  }

  Future<void> send() async {
    try {
      final dynamic result = await LoginDao.login(userName!, password!);
      print(result);
      if (result['code'] == 0) {
        showToast('success');
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e.message);
    } on NeedLogin catch (e) {
      print(e.message);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }
}
