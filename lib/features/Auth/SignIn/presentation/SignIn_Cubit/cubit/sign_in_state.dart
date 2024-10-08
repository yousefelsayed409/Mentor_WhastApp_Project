part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInFailureState extends SignInState {
  final String errorMessage;

  SignInFailureState({required this.errorMessage});
}

class UpdateUserProfileSuccessState extends SignInState {}

class UpdateUserProfileFailureState extends SignInState {
  final String errorMessage;

  UpdateUserProfileFailureState({required this.errorMessage});
}
class ForgotpasswordLoadingState extends SignInState {}
class ForgorpasswordSuccessState extends SignInState {}
class ForgorpasswordFailureState extends SignInState {
  final String errorMessage;

  ForgorpasswordFailureState({required this.errorMessage});
} 

class SignOutSuccessState extends SignInState {}
class SignOutFailureState extends SignInState {
   final String errorMessage;

  SignOutFailureState({required this.errorMessage});
}
