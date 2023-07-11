part of 'login_controller.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
  errorLogin,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;

  const LoginState(
    this.status,
    this.errorMessage,
  );

  const LoginState.initial()
      : status = LoginStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status ?? this.status,
      errorMessage ?? this.errorMessage,
    );
  }
}
