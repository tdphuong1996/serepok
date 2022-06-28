import 'dart:async';
import 'dart:convert';

import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/repository/auth_repository.dart';
import '../../res/constant.dart';

class LoginProvider extends BaseProvider {
  final AuthRepository _authRepository = AuthRepository();
  Function(bool)? loginCallback = null;

  void login(String email, String password) {
    showLoading();
    final param = {'email': email, 'password': password};
    _authRepository.login<User>(param).then(loginData).onError(handleError);
  }

  FutureOr loginData(User value) async {
    await saveDataLogin(value);
    loginCallback?.call(true);
    hideLoading();
  }

  Future<bool> saveDataLogin(User value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(Constant.PREF_USER, jsonEncode(value.toJson()));
  }
}
