import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentorwhatsapp/features/home/data/model/user_model.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  late String? email;
  late String? password;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  // تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
  Future<void> signinUserWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? email!.split('@')[0],
        pfpURL: userCredential.user!.photoURL ?? '', 
      );

      

      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailureState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SignInFailureState(errorMessage: 'Check your Email and Password.'));
      } else {
        emit(SignInFailureState(errorMessage: 'Check your Email and Password'));
      }
    }
  }

  
  // تسجيل الخروج
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(SignOutFailureState(errorMessage: e.toString()));
    }
  }

  // استعادة كلمة المرور
  Future<void> forgotPasswordWithEmail() async {
    try {
      emit(ForgotpasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      emit(ForgorpasswordSuccessState());
    } catch (e) {
      emit(ForgorpasswordFailureState(errorMessage: e.toString()));
    }
  }

  
}
