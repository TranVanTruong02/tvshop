import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/home_controller.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    // Lấy ID trò chuyện khi khởi tạo bộ điều khiển.
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollection);

  var vendorName = Get.arguments[0];
  var vendorId = Get.arguments[1];

  var userName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var massagesTextController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  // lấy ID trò chuyện hiện có hoặc tạo mới.
  getChatId() async {
    isLoading(true);
    // Câu truy vấn
    final query = chats.where('ch_users',
        isEqualTo: {'vendor_id': vendorId, 'user_id': currentId}).limit(1);

    await query.get().then((QuerySnapshot snapshot) {
      // Nếu tồn tại trò chuyện giữa hai người dùng, phương thức này sẽ tìm kiếm trò chuyện đó trong bộ sưu tập trò chuyện
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      } else {
        // Nếu không tồn tại trò chuyện, phương thức này sẽ tạo một trò chuyện mới. Trò chuyện mới sẽ được lưu trữ trong bộ sưu tập trò chuyện với ID được tạo ngẫu nhiên.
        chats.add({
          'ch_created_on': null,
          'ch_last_message': '',
          'ch_users': {'vendor_id': vendorId, 'user_id': currentId},
          'ch_toId': '',
          'ch_fromId': '',
          'ch_v_name': vendorName, //  Truy xuất chi tiết người nhận.
          'ch_u_name': userName, // truy cập thông tin người gửi.
        }).then((value) {
          chatDocId = value.id;
        });
      }
    });
    isLoading(false);
  }

  // Sử dụng sendMessages() để gửi tin nhắn và cập nhật dữ liệu trò chuyện.
  sendMessages(String msg) async {
    // Nếu tin nhắn không trống, phương thức sẽ cập nhật tài liệu trò chuyện hiện tại với nội dung tin nhắn, dấu thời gian, ID người gửi và ID người nhận.
    if (msg.trim().isNotEmpty) {
      await chats.doc(chatDocId).update({
        'ch_created_on': FieldValue.serverTimestamp(),
        'ch_last_message': msg,
        'ch_toId': vendorId,
        'ch_fromId': currentId,
      });

      // Sau đó, phương thức sẽ tạo một tài liệu mới trong bộ sưu tập con messages của trò chuyện. Tài liệu mới sẽ chứa nội dung tin nhắn, dấu thời gian và ID người gửi.
      await chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'm_created_on': FieldValue.serverTimestamp(),
        'm_message': msg,
        'uid': currentId,
      });
    }
  }
}
