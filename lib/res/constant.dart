class StateApp {
  StateApp._();

  factory StateApp.success(bool isLoading) = LoadingState;

  factory StateApp.error(String foo) = ErrorState;
}

class ErrorState extends StateApp {
  ErrorState(this.msg) : super._();

  final String msg;
}

class LoadingState extends StateApp {
  LoadingState(this.isLoading) : super._();
  final bool isLoading;
}

class Constant {
  static const PREF_USER = "PREF_USER";
}
