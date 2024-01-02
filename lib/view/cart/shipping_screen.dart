import 'package:get/get.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/common/custom_textfield.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/cart_controller.dart';
import 'package:tvshop/view/cart/payment_method.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: blue,
        title: "j".text.size(18).fontFamily(semibold).color(whiteColor).make(),
      ),
      bottomNavigationBar: customButton(
              color: lightGrey,
              onPress: () {
                Get.to(() => const PaymentMothods());
              },
              title: "Continue ",
              textColor: redColor,
              width: context.screenWidth,
              height: 50,
              size: 18)
          .box
          .width(context.screenWidth)
          .make(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
        child: Column(children: [
          customTextField(
              title: address,
              hint: hintAddress,
              isPass: false,
              controller: controller.addressController),
          5.heightBox,
          customTextField(
              title: city,
              hint: hintCity,
              isPass: false,
              controller: controller.cityController),
          5.heightBox,
          customTextField(
              title: state,
              hint: hintState,
              isPass: false,
              controller: controller.stateController),
          5.heightBox,
          customTextField(
              title: postalCode,
              hint: hintPostalCode,
              isPass: false,
              controller: controller.postalCodeController),
          5.heightBox,
          customTextField(
              title: phone,
              hint: hintPhone,
              isPass: false,
              controller: controller.phoneController),
          5.heightBox,
          "Vui lòng điền đầy đủ thông tin trước khi tiếp tục."
              .text
              .size(12)
              .fontFamily(italic)
              .color(fontGrey)
              .make(),
        ]),
      ),
    );
  }
}
