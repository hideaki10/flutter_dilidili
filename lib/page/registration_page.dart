import 'package:flutter/material.dart';
import 'package:flutter_dilidili/http/core/hi_error.dart';
import 'package:flutter_dilidili/http/dao/login_dao.dart';
import 'package:flutter_dilidili/util/string_util.dart';
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
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("register", "login", widget.onJumptoLogin!),
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
                userName = text;
                checkInput();
              },
              focusChanged: (focus) {},
            ),
            LoginInput(
              hint: 'input you password',
              title: 'password',
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              hint: 'input you password',
              title: 'password',
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              hint: 'input you imoocId',
              title: 'imoocid',
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
              keyboardType: TextInputType.number,
              focusChanged: (focus) {},
            ),
            LoginInput(
              hint: 'input you orderId',
              title: 'orderId',
              keyboardType: TextInputType.number,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
              focusChanged: (focus) {},
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool _enable;
    if (isNotEmpty(userName!) &&
        isNotEmpty(password!) &&
        isNotEmpty(rePassword!) &&
        isNotEmpty(imoocId!) &&
        isNotEmpty(orderId!)) {
      _enable = true;
    } else {
      _enable = false;
    }
    setState(() {
      loginEable = _enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEable) {
          checkParam();
        } else {
          print("loginEbable is false");
        }
      },
      child: Text('zhuce'),
    );
  }

  Future<void> send() async {
    try {
      dynamic result =
          await LoginDao.registration("test", "rootroot", "8448121", "3923");
      print(result);
      if (result["code"] == 0) {
        print("success");
        if (widget.onJumptoLogin != null) {
          widget.onJumptoLogin!;
        }
      }
    } on NeedAuth catch (e) {
      print(e.message);
    } on NeedLogin catch (e) {
      print(e.message);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  void checkParam() {
    String? tips;
    if (password != password) {
      tips = "liangci";
    } else if (orderId!.length != 4) {
      tips = "dadd";
    }
    if (tips != null) {
      return;
    }
    send();
  }
}
