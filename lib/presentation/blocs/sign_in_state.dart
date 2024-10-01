import 'package:task_manager_app/domain/entities/user.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final User user; // Assuming you have a User entity defined

  SignInSuccess({required this.user});
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure({required this.error});
}
