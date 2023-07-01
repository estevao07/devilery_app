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

  const RegisterState({
    required this.status,
  });

  const RegisterState.initial() : status = RegisterStatus.initial;

  @override
  List<Object> get props => [];

  RegisterState copyWith({
    RegisterStatus? status,
  }) {
    return RegisterState(
      status: status ?? this.status,
    );
  }
}
