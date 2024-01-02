import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  // Đường dẫn
  var profileImgPath = ''.obs; // Ảnh được đổi
  var profileImgLink = '';

  // Load dữ liệu
  var isLoading = false.obs;

  // Text controllers
  var nameController = TextEditingController();
  var passwordOldController = TextEditingController();
  var passwordNewController = TextEditingController();

  // Đổi ảnh đại diện. Cho phép người dùng chọn một hình ảnh từ thư viện ảnh, sau đó lưu đường dẫn của hình ảnh đã chọn vào biến profileImgPath.
  changImage(context) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image == null) {
        return;
      }
      profileImgPath.value = image.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // Cập nhật ảnh đại diện
  uploadProfileImage() async {
    var filename = basename(profileImgPath
        .value); // Lấy tên file của hình ảnh từ đường dẫn đã lưu trong biến profileImgPath.
    var destination =
        'images/${currentUser!.uid}/$filename'; // Xác định đường dẫn đích (destination) trên Firebase Storage để lưu hình ảnh.
    Reference reference = FirebaseStorage.instance.ref().child(
        destination); // Tạo một tham chiếu (reference) đến vị trí lưu trữ trên Firebase Storage.
    await reference.putFile(File(profileImgPath
        .value)); // Tải lên hình ảnh lên Firebase Storage bằng cách sử dụng phương thức putFile.
    // Lấy lại đường dẫn
    profileImgLink = await reference.getDownloadURL();
  }

  updateProfie({name, password, imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({'u_name': name, 'u_password': password, 'u_img_url': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword({email, oldpassword, newpassword}) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      await currentUser!
          .reauthenticateWithCredential(credential)
          .then((value) => currentUser!.updatePassword(newPassword));
    } catch (e) {
      print(e.toString());
    }
  }
}
