import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/common/loading_indicator.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/cart_controller.dart';
import 'package:tvshop/services/firestore_services.dart';
import 'package:tvshop/view/cart/shipping_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: shoppingCart.text
              .size(20)
              .fontFamily(semibold)
              .color(whiteColor)
              .make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: cartIsEmpty.text
                    .size(18)
                    .fontFamily(semibold)
                    .color(fontGrey)
                    .make(),
              );
            } else {
              // Biến dữ liệu nhận về
              var data = snapshot.data!.docs;
              controller.caculatate(data);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['c_p_img']}",
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                                title: AutoSizeText(
                                  "${data[index]['c_p_name']} (x${data[index]['c_quantity']})",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontFamily: semibold),
                                  maxLines: 1,
                                  overflow: TextOverflow
                                      .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
                                ),
                                subtitle: "${data[index]['c_totalprice']}"
                                    .numCurrency
                                    .text
                                    .size(16)
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteCart(data[index].id);
                                }),
                              );
                            })),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        totalPrice.text
                            .size(18)
                            .fontFamily(bold)
                            .color(blue)
                            .make(),
                        Obx(
                          () => "${controller.totalPrice.value}"
                              .text
                              .size(18)
                              .fontFamily(bold)
                              .color(Colors.red)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .width(context.screenWidth * 0.9)
                        .color(lightGrey)
                        .roundedSM
                        .shadowSm
                        .make(),
                    10.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customButton(
                                  color: blue,
                                  onPress: () {},
                                  title: addNewProduct,
                                  textColor: whiteColor,
                                  width: context.screenWidth * 0.4,
                                  height: 50,
                                  size: 16)
                              .box
                              .width(context.screenWidth * 0.4)
                              .shadowXl
                              .make(),
                          customButton(
                                  color: redColor,
                                  onPress: () {
                                    controller.productSnapshot = data;
                                    Get.to(() => const ShippingDetails());
                                  },
                                  title: purchase,
                                  textColor: whiteColor,
                                  width: context.screenWidth * 0.4,
                                  height: 50,
                                  size: 16)
                              .box
                              .width(context.screenWidth * 0.4)
                              .shadowLg
                              .make(),
                        ]),
                    5.heightBox
                  ],
                ),
              );
            }
          },
        ));
  }
}
