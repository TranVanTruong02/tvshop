import 'package:get/get.dart';
import 'package:tvshop/consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0
      .obs; // ví dụ như currentNavIndex.value = 1;, các thành phần khác trong ứng dụng (ví dụ: giao diện người dùng) sẽ được thông báo về sự thay đổi này và có thể cập nhật tương ứng.
  // .obs ở cuối. Điều này chỉ ra rằng biến currentNavIndex là một biến quan sát (observable variable).
  // Điều này giúp theo dõi các thay đổi của biến và tự động cập nhật giao diện người dùng khi giá trị của biến thay đổi.

  var username = '';

  getUsername() async {
    var name = await firestore
        .collection(usersCollection)
        .where('user_id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['u_name'];
      } else {
        return "";
      }
    });

    username = name;
  }
}
