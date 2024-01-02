import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/loading_indicator.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/services/firestore_services.dart';
import 'package:tvshop/view/orders/order_details.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "Đơn hàng của bạn".text.white.size(18).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Không có đơn hàng nào."
                    .text
                    .size(18)
                    .fontFamily(semibold)
                    .color(fontGrey)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data
                      .length, // Đặt số lượng phần tử trong danh sách bằng độ dài của data
                  itemBuilder: (BuildContext context, int index) {
                    // hàm xây dựng (builder function) được gọi để tạo ra các phần tử trong danh sách
                    return ListTile(
                      leading:
                          "${index + 1}" // Phần tử hiển thị ở bên trái của ListTile
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                      title: data[index][
                              'o_code'] // Phần tử hiển thị ở giữa của ListTile.
                          .toString()
                          .text
                          .size(16)
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index][
                              'o_total_amount'] // hần tử hiển thị ở phía dưới title của ListTile
                          .toString()
                          .numCurrency
                          .text
                          .size(12)
                          .color(fontGrey)
                          .fontFamily(semibold)
                          .make(),
                      trailing: IconButton(
                          // Phần tử hiển thị ở bên phải của ListTile
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          )),
                      contentPadding: const EdgeInsets.all(10),
                      tileColor: whiteColor,
                      selectedTileColor: redColor,
                      onTap: () {
                        Get.to(() => OrderDetails(data: data[index]));
                      },
                    );
                  });
            }
          }),
    );
  }
}
