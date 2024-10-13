import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  late String? name;
  late String? email;
  late String? password;
  bool termsAndCondition = false;
  
  XFile? profilePic;   
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      emit(SignupLoadingState());
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
        
      );
      String uid = userCredential.user!.uid;

      String profilePicURL = profilePic != null ? profilePic!.path : '';

      await createOrUpdateUserInFirestore(
        uid: uid,
        name: name!,
        pfpURL: profilePicURL,
        
      );

      emit(SignupSuccessState(uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailureState(
            errorMessage: 'كلمة المرور ضعيفة جداً.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailureState(
            errorMessage: 'البريد الإلكتروني مستخدم بالفعل.'));
      } else if (e.code == 'invalid-email') {
        emit(SignupFailureState(errorMessage: 'البريد الإلكتروني غير صالح.'));
      }
    } catch (e) {
      emit(SignupFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> createOrUpdateUserInFirestore({
    required String uid,
    required String name,
    required String pfpURL,
  }) async {
    try {
      CollectionReference users = firebase.collection('users');

      DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        await users.doc(uid).update({
          'name': name,
          'profilePic': pfpURL,
        });
      } else {
        await users.doc(uid).set({
          'id': uid,
          'name': name,
          'profilePic': pfpURL, 
          
        });
      }
    } catch (e) {
      print('Error while creating/updating user: $e');
    }
  }

  void termesAndCondition({required newValue}) {
    termsAndCondition = newValue;
    emit(TermesAndConditionState());
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UpLoadImageState());
  }
}
