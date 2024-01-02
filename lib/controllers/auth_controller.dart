import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tvshop/consts/consts.dart';

class AuthController extends GetxController {
  // kế thừa từ GetXController, để quản lý các phương thức liên quan đến xác thực người dùng và tương tác với Cloud Firestore.

  // Biến load dữ liệu
  var isLoading = false.obs;

  // Text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login method
  Future<UserCredential?> loginMethod({context}) async {
    //  UserCredential là một đối tượng chứa thông tin xác thực của người dùng sau khi đăng nhập thành công vào hệ thống. 
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController
              .text); // đăng nhập người dùng bằng cách sử dụng phương thức signInWithEmailAndPassword của đối tượng auth (từ gói firebase_auth).
    } on FirebaseAuthException catch (e) {
      // Nếu lỗi thì đưa ra thông báo
      VxToast.show(context, msg: "Tài khoản hoặc mật khẩu không chính xác".toString());
    }
    return userCredential;
  }

  // signup method
  Future<UserCredential?> sigupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          // phương thức này được sử dụng để đăng ký tài khoản người dùng bằng cách sử dụng phương thức createUserWithEmailAndPassword của đối tượng auth.
          email: email,
          password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // storing data method
  storeUserData({name, password, email}) async {
    // phương thức không đồng bộ sử dụng để lưu trữ thông tin người dùng vào cơ sở dữ liệu Cloud Firestore.
    DocumentReference store = await firestore.collection(usersCollection).doc(
        currentUser!
            .uid); // tạo một tài liệu mới trong bộ sưu tập usersCollection
    store.set({
      'user_id': currentUser!.uid,
      'u_name': name,
      'u_password': password,
      'u_email': email,
      'u_img_url': '',
      'u_cart_count': "00",
      'u_order_count': "00",
      'u_wishlist': "00",
    });
  }

  // signout method
  signoutMethod(context) async {
    try {
      await auth
          .signOut(); // phương thức không đồng bộ được sử dụng để đăng xuất người dùng bằng cách sử dụng phương thức signOut của đối tượng auth.
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
