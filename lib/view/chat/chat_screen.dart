import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/loading_indicator.dart';
import 'package:tvshop/common/sender_bubble.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/chat_controller.dart';
import 'package:tvshop/services/firestore_services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key}); // constructor của class ChatScreen nhận một tham số đặt tên key.

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: blue,
          title: "${controller.vendorName}"
              .text
              .size(18)
              .fontFamily(semibold)
              .color(whiteColor)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: loadingIndicator(),
                      )
                    : Expanded(
                        child: StreamBuilder(
                            stream: FirestoreServices.getChatMessages(
                              controller.chatDocId.toString(),
                            ),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: thereAreNoMessages.text
                                      .size(18)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              } else {
                                return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                    var data = snapshot.data!.docs[index];
                                    return Align(
                                        alignment:
                                            data['uid'] == currentUser!.uid
                                                ? Alignment.center
                                                : Alignment.centerLeft,
                                        child: senderBubble(data));
                                  }).toList(),
                                );
                              }
                            }),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.massagesTextController,
                      decoration: InputDecoration(
                        filled: true, // Cho phép tô màu
                        fillColor: lightGreyTextField,
                        labelStyle:
                            const TextStyle(fontFamily: regular, fontSize: 16),
                        hintText: typeAMessage,
                        hintStyle:
                            const TextStyle(color: textfieldGrey, fontSize: 16),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(27.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(27.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 19, 133, 226),
                              width: 2),
                          borderRadius: BorderRadius.circular(27.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await controller.sendMessages(
                            controller.massagesTextController.text);
                        // Sau khi gửi tin nhắn thì xóa đi
                        controller.massagesTextController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: redColor,
                      ))
                ],
              )
                  .box
                  .height(70)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 5))
                  .make()
            ],
          ),
        ));
  }
}
