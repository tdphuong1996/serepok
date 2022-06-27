import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  TextEditingController _userNameTextcontroller = TextEditingController();
  TextEditingController _passwordTextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _loginProvider.context = context;
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
              textField('Tên tài khoản', _userNameTextcontroller, false),
              textField('Mật khẩu', _passwordTextcontroller, true),
              const SizedBox(
                height: 16,
              ),
              loginButton()
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    final username = _userNameTextcontroller.text;
    final password = _passwordTextcontroller.text;
    if (username.isEmpty || password.isEmpty) {
      _loginProvider.showAlert("Vui lòng nhập đầy đủ thông tin");
      return;
    }

    _loginProvider.login(username, password);
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
          padding:
              const EdgeInsets.only(top: 8, left: 32, right: 32, bottom: 8),
          pressedOpacity: 0.5,
          child: const Text('Đăng nhập')),
    );
  }

  Widget textField(
      String placeholder, TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(labelText: placeholder),
    );
  }
}
