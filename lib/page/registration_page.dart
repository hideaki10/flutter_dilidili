import 'package:flutter/material.dart';
import 'package:flutter_dilidili/http/core/hi_error.dart';
import 'package:flutter_dilidili/http/dao/login_dao.dart';
import 'package:flutter_dilidili/navigator/hi_navigator.dart';
import 'package:flutter_dilidili/util/string_util.dart';
import 'package:flutter_dilidili/widget/appbar.dart';
import 'package:flutter_dilidili/widget/login_button.dart';
import 'package:flutter_dilidili/widget/login_effect.dart';
import 'package:flutter_dilidili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegiState createState() => _RegiState();
}

class _RegiState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('register', 'login', () {
        HiNavigator.getNaviatorInstance.onJumpTo(RouteStatus.login);
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
              onChanged: (String text) {
                userName = text;
              },
              focusChanged: (_) {},
            ),
            LoginInput(
              hint: 'input you password',
              title: 'password',
              onChanged: (String text) {
                password = text;
              },
              focusChanged: (bool focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              hint: 'input you password',
              title: 'password',
              onChanged: (String text) {
                rePassword = text;
              },
              focusChanged: (bool focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              hint: 'input you imoocId',
              title: 'imoocid',
              onChanged: (String text) {
                imoocId = text;
              },
              keyboardType: TextInputType.number,
              focusChanged: (_) {},
            ),
            LoginInput(
              hint: 'input you orderId',
              title: 'orderId',
              keyboardType: TextInputType.number,
              onChanged: (String text) {
                orderId = text;
                checkInput();
              },
              focusChanged: (bool focus) {},
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                  title: '注册', enable: loginEnable, onPressed: checkParams),
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
      loginEnable = _enable;
    });
  }

  Future<void> send() async {
    try {
      final dynamic result =
          await LoginDao.registration('test', 'rootroot', '8448121', '3923');
      print(result);
      if (result['code'] == 0) {
        print('success');
      }
    } on NeedAuth catch (e) {
      print(e.message);
    } on NeedLogin catch (e) {
      print(e.message);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != password) {
      tips = 'liangci';
    } else if (orderId!.length != 4) {
      tips = 'dadd';
    }
    if (tips != null) {
      return;
    }
    send();
  }
}
