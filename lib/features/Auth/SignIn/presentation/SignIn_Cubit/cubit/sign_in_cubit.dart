import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentorwhatsapp/features/home/data/model/user_model.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  late String? email;
  late String? password;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> signinUserWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      await firebase.collection('users').doc(userCredential.user!.uid).update({
        'isOnline': true,
        'lastSeen': FieldValue.serverTimestamp(),
      });

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

  Future<void> signOut() async {
    try {
      await firebase.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
      });

      await FirebaseAuth.instance.signOut();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(SignOutFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> forgotPasswordWithEmail() async {
    try {
      emit(ForgotpasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      emit(ForgorpasswordSuccessState());
    } catch (e) {
      emit(ForgorpasswordFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    String? email,
    String? password,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: name);

        if (email != null && email.isNotEmpty) {
          await user.verifyBeforeUpdateEmail(email);
          emit(UpdateUserProfileSuccessState());
        }

        if (password != null && password.isNotEmpty) {
          await user.updatePassword(password);
        }

        emit(UpdateUserProfileSuccessState());
      }
    } catch (e) {
      emit(UpdateUserProfileFailureState(errorMessage: e.toString()));
    }
  }
}
