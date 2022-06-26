import 'dart:async';

import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/user.dart';

import '../../api/repository/auth_repository.dart';

class LoginProvider extends BaseProvider {
  final AuthRepository _authRepository = AuthRepository();
  Function(bool)? loginCallback = null;

  void login(String email, String password) {
    showLoading();
    final param = {'email': email, 'password': password};
    _authRepository.login<User>(param).then(loginData).onError(handleError);
  }

  FutureOr loginData(User value) {
    hideLoading();
    loginCallback?.call(true);
    print("name ${value.name}");
  }
}
