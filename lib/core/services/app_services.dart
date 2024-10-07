
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentorwhatsapp/features/home/data/model/user_model.dart';
import 'package:path/path.dart' as p;


class AppService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance; 
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; 
    CollectionReference ?userCollection;
    UserModel ? userModel;



  Future<XFile?> getImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  } 


  Future<String?> uploadImageUser({required File file, required String uid}) async {
    try {
      Reference fileRef = firebaseStorage.ref('users/pfps').child("$uid${p.extension(file.path)}");

      UploadTask task = fileRef.putFile(file);

      return task.then((p) {
        if (p.state == TaskState.success) {
          return fileRef.getDownloadURL();
        }
        return null;
      });
    } catch (e) {
      print('حدث خطأ أثناء رفع الصورة: $e');
      return null;
    }
  }


}
