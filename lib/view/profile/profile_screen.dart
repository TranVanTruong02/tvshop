import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/background_widget.dart';
import 'package:tvshop/common/button_profile.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tvshop/consts/lists.dart';
import 'package:tvshop/controllers/auth_controller.dart';
import 'package:tvshop/controllers/profile_controller.dart';
import 'package:tvshop/services/firestore_services.dart';
import 'package:tvshop/view/auth/login_screen.dart';
import 'package:tvshop/view/chat/message_screen.dart';
import 'package:tvshop/view/orders/order_screen.dart';
import 'package:tvshop/view/profile/profile_edit.dart';
import 'package:tvshop/view/wishlist/wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return backgroundWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              // Hiện Indicator load dữ liệu
              return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)));
            } else {
              // Load dữ liệu
              var data = snapshot.data!.docs[0];

              return SafeArea(
                // đảm bảo rằng nội dung trong widget của bạn không bị che phủ hoặc bị cắt bởi các phần tử như thanh trạng thái (status bar), thanh điều hướng (navigation bar) hoặc các phần tử khác trên màn hình.
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // edit profile button
                      const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        // Lấy dữ liệu từ data chuyền vào customTexxfiel
                        controller.nameController.text = data['u_name'];
                        Get.to(() => ProfileEdit(data: data));
                      }),

                      // user details section
                      10.heightBox,
                      Row(
                        children: [
                          data['u_img_url'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['u_img_url'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          5.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['u_name']}"
                                  .text
                                  .size(16)
                                  .white
                                  .fontFamily(bold)
                                  .make(),
                              AutoSizeText(
                                "${data['u_email']}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow
                                    .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
                              )
                            ],
                          )),
                          10.widthBox,
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                color: whiteColor,
                              )),
                              onPressed: () async {
                                // Đăng xuất
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: logout.text.white
                                  .size(14)
                                  .fontFamily(semibold)
                                  .make())
                        ],
                      ),

                      30.heightBox,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buttonProfile(
                                width: context.screenWidth / 3.5,
                                height: context.screenHeight * 0.08,
                                count: "${data['u_cart_count']}",
                                title: "Giỏ hàng"),
                            buttonProfile(
                                width: context.screenWidth / 3.5,
                                height: context.screenHeight * 0.08,
                                count: "${data['u_order_count']}",
                                title: "Yêu thích "),
                            buttonProfile(
                                width: context.screenWidth / 3.5,
                                height: context.screenHeight * 0.08,
                                count: "${data['u_wishlist']}",
                                title: "Hóa đơn"),
                          ]),

                      // Buttuon Section
                      40.heightBox,
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                        itemCount: profileScreenButton.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const WishlistScreen());
                                  break;
                                case 1:
                                  Get.to(() => const OrderScreen());
                                  break;
                                case 2:
                                  Get.to(() => const MessageScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileScreenImages[index],
                              width: 22,
                            ),
                            title: profileScreenButton[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.fromLTRB(10, 0, 10, 0))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make(),
                    ],
                  ),
                ),
              );
            }
          }),
    ));
  }
}
