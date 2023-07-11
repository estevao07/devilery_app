// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_controller.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? errorMessage;

  const RegisterState({
    required this.status,
    this.errorMessage,
  });

  const RegisterState.initial()
      : status = RegisterStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
