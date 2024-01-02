import 'package:get/get.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/common/loading_indicator.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/consts/lists.dart';
import 'package:tvshop/controllers/cart_controller.dart';
import 'package:tvshop/view/home/home_main.dart';

class PaymentMothods extends StatelessWidget {
  const PaymentMothods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: blue,
          title: choosePaymentMethod.text
              .size(18)
              .fontFamily(semibold)
              .color(whiteColor)
              .make(),
        ),
        bottomNavigationBar: controller.placingOrder.value
            ? Center(
                child: loadingIndicator(),
              )
            : customButton(
                    color: lightGrey,
                    onPress: () async {
                      await controller.placeMyOrder(
                          orderPaymentMethod:
                              paymentMethodsText[controller.paymentIndex.value],
                          totalAmount: controller.totalPrice.value);

                      // Xóa sản phẩm trong giỏ hàng
                      await controller.clearCart();
                      VxToast.show(context, msg: "Bạn đã đặt hàng thành công");
                      Get.offAll(const HomeMain());
                    },
                    title: placeMyOrder,
                    textColor: redColor,
                    width: context.screenWidth,
                    height: 50,
                    size: 18)
                .box
                .width(context.screenWidth)
                .make(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
            child: Obx(
              () => Column(
                children: List.generate(paymentMethodsList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: controller.paymentIndex.value == index
                                  ? redColor
                                  : Colors.transparent,
                              width: 4)),
                      margin: const EdgeInsets.only(top: 10),
                      child: Stack(alignment: Alignment.topRight, children: [
                        Image.asset(
                          paymentMethodsList[index],
                          width: double.infinity,
                          height: 100,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            right: 10,
                            bottom: 10,
                            child: paymentMethodsText[index].text.white.make()),
                      ]),
                    ),
                  );
                }),
              ),
            ),
          ),
          "Vui lựa chọn hình thức thanh toán phù hợp với bạn"
              .text
              .size(12)
              .color(fontGrey)
              .fontFamily(italic)
              .make(),
        ]),
      ),
    );
  }
}
