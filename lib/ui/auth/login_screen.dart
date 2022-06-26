import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serepok/ui/auth/login_provider.dart';
import 'package:flutter/cupertino.dart';
import '../../res/AppThemes.dart';
import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginProvider _loginProvider;

  @override
  void initState() {
    super.initState();
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _loginProvider.loginCallback = (issss) {
      Navigator.of(context).pushNamed(Routes.HOME_SCREEN);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Xin Chào"),
              textField('Tên tài khoản'),
              textField('Mật khẩu'),
              const SizedBox(height: 16,),
              loginButton()
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    _loginProvider.login("sauriengsarepok@gmail.com", "123456",);
  }

  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
          color: MyColor.PRIMARY_COLOR,
          onPressed: () {
            login();
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          padding: const EdgeInsets.only(
              top: 8, left: 32, right: 32, bottom: 8),
          pressedOpacity: 0.5,
          child: const Text('Đăng nhập')),
    );
  }

  Widget textField(String placeholder) {
    return TextFormField(
      decoration: InputDecoration(labelText: placeholder),
    );
  }
}
