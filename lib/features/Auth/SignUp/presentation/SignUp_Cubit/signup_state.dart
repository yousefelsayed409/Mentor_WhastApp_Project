// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final String uid;
  SignupSuccessState(this.uid);  // تعديل لاستقبال uid
}
class SignupFailureState extends SignupState {
  String errorMessage;
  SignupFailureState({
    required this.errorMessage,
  });
}
class UpLoadImageState extends SignupState {}

class TermesAndConditionState extends SignupState {}

