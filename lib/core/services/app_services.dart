import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mentorwhatsapp/features/home/data/model/user_model.dart';
import 'package:path/path.dart' as p;

class AppService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? userCollection;
  UserModel? userModel;
  // final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;

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

  // Future<String?> startRecording() async {
  //   try {
  //     await _recorder.openRecorder();
  //     String path = '${Directory.current.path}/recording.aac'; // يمكنك تغيير اسم الملف إذا أردت
  //     await _recorder.startRecorder(toFile: path);
  //     _isRecording = true;
  //     return path;
  //   } catch (e) {
  //     print('حدث خطأ أثناء بدء التسجيل: $e');
  //     return null;
  //   }
  // }

  // Future<String?> stopRecording() async {
  //   try {
  //     String? path = await _recorder.stopRecorder();
  //     _isRecording = false;
  //     await _recorder.closeRecorder();
  //     return path;
  //   } catch (e) {
  //     print('حدث خطأ أثناء إيقاف التسجيل: $e');
  //     return null;
  //   }
  // }

  // Future<String?> uploadAudio({required File audioFile, required String uid}) async {
  //   try {
  //     Reference fileRef = firebaseStorage.ref('users/audio').child("$uid/${p.basename(audioFile.path)}");

  //     UploadTask task = fileRef.putFile(audioFile);

  //     return task.then((p) {
  //       if (p.state == TaskState.success) {
  //         return fileRef.getDownloadURL();
  //       }
  //       return null;
  //     });
  //   } catch (e) {
  //     print('حدث خطأ أثناء رفع الصوت: $e');
  //     return null;
  //   }
  // }
}
