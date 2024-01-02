import 'package:tvshop/common/order_status.dart';
import 'package:tvshop/common/placed_details.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: darkFontGrey,
        ),
        title: "hhhh".text.make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
              icon: Icons.shopping_bag_rounded,
              color: redColor,
              title: orderPlaced,
              showDone: data['o_placed'],
              width: context.screenWidth,
            ),
            5.heightBox,
            orderStatus(
              icon: Icons.thumb_up,
              color: blue,
              title: orderConfirmed,
              showDone: data['o_confirmed'],
              width: context.screenWidth,
            ),
            5.heightBox,
            orderStatus(
              icon: Icons.car_crash,
              color: Colors.yellow,
              title: orderDelivered,
              showDone: data['o_delivered'],
              width: context.screenWidth,
            ),
            5.heightBox,
            orderStatus(
              icon: Icons.done_all_sharp,
              color: Colors.purple,
              title: orderOnDelivered,
              showDone: data['o_on_delivered'],
              width: context.screenWidth,
            ),
            const Divider(), // Thanh ngang
            5.heightBox,
            Column(
              children: [
                placedDetails(
                    title1: orderCode,
                    title2: shippingMethod,
                    data1: data['o_code'],
                    data2: data['o_shipping_method'],
                    width1: context.screenWidth / 2,
                    width2: context.screenWidth / 2),
                placedDetails(
                    title1: orderDate,
                    title2: paymentMethod,
                    data1: intl.DateFormat()
                        .add_yMd()
                        .format((data['o_date'].toDate())),
                    data2: data['o_payment_method'],
                    width1: context.screenWidth / 2,
                    width2: context.screenWidth / 2),
                placedDetails(
                    title1: paymentStatus,
                    title2: deliveredStatus,
                    data1: "Chưa thanh toán",
                    data2: "Đã đặt hàng",
                    width1: context.screenWidth / 2,
                    width2: context.screenWidth / 2),
                Row(
                  children: [
                    Column(
                      children: [
                        paymentAddress.text
                            .size(16)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_u_name']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_u_email']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_address']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_city']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_state']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_postal_code']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_phone']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      ],
                    ).box.width((context.screenWidth - 12) * 0.6).make(),
                    Column(
                      children: [
                        totalAmount.text
                            .size(16)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${data['o_total_amount']}"
                            .text
                            .size(14)
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                      ],
                    ).box.width((context.screenWidth - 12) * 0.4).make(),
                  ],
                )
              ],
            )
                .box
                .white
                .padding(const EdgeInsets.all(12))
                .roundedSM
                .shadowSm
                .make(),

            const Divider(),
            10.heightBox,
            orderedProducts.text
                .size(16)
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
            ListView(
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      placedDetails(
                          title1: "${data['orders'][index]['c_p_name']}",
                          title2: data['orders'][index]['c_totalprice'],
                          data1: "x${data['orders'][index]['c_quantity']}",
                          data2: "Có thể hủy"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data['orders'][index]['c_p_color']),
                        ),
                      )
                    ]);
              }),
            ),
            20.heightBox
          ],
        ),
      ),
    );
  }
}
