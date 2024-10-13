import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class AppService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<XFile?> getImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> getFileFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file = await imagePicker.pickVideo(source: ImageSource.gallery); // أو استخدام source: ImageSource.gallery إذا كنت تريد ملفات غير الصور
    return file;
  }

  Future<String?> uploadImageUser({required File file, required String uid}) async {
    try {
      Reference storageRef = firebaseStorage.ref('users/images').child("$uid/${p.basename(file.path)}");

      UploadTask uploadTask = storageRef.putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        return await storageRef.getDownloadURL();
      }
      return null;
    } catch (e) {
      print('حدث خطأ أثناء رفع الصورة: $e');
      return null;
    }
  }

  Future<String?> uploadFile({required File file, required String uid}) async {
    try {
      Reference fileRef = firebaseStorage.ref('users/files').child("$uid/${p.basename(file.path)}");

      UploadTask task = fileRef.putFile(file);

      TaskSnapshot snapshot = await task;

      if (snapshot.state == TaskState.success) {
        return await fileRef.getDownloadURL();
      }
      return null;
    } catch (e) {
      print('حدث خطأ أثناء رفع الملف: $e');
      return null;
    }
  }

 Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none);
  }
}
