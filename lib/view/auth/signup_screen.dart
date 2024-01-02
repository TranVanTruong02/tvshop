import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/background_widget.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/common/custom_textfield.dart';
import 'package:tvshop/common/logo_widget.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/auth_controller.dart';
import 'package:tvshop/view/home/home_main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Khai báo
  bool? isCheck = false;

  // connect Firebase
  var controller = Get.put(
      AuthController()); // cho phép lớp AuthController được quản lý bởi GetX và có thể được truy cập từ bất kỳ đâu trong ứng dụng.

  // Text Controller
  var nameController =
      TextEditingController(); // Biến này được sử dụng để kết nối và điều khiển một trường văn bản trong giao diện người dùng, cho phép người dùng nhập và chỉnh sửa nội dung của trường đó.
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            // Logo
            (context.screenHeight * 0.1).heightBox,
            appLogo(),
            10.heightBox,

            // Title
            "Join the $appname".text.white.fontFamily(bold).size(20).make(),
            20.heightBox,

            // Tạo 1 cột
            Obx(() => Column(children: [
                  // TextField
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  5.heightBox,
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  5.heightBox,
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true),
                  5.heightBox,
                  customTextField(
                      title: retypePassword,
                      hint: passwordHint,
                      controller: passwordRetypeController,
                      isPass: true),
                  10.heightBox,

                  // Checkbox
                  Row(
                    children: [
                      Checkbox(
                          value: isCheck,
                          activeColor: redColor,
                          checkColor: whiteColor,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      10.widthBox,

                      // Text
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: termAndConditions,
                                  style: TextStyle(
                                      fontFamily: regular, color: redColor)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.heightBox,

                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : customButton(
                              color: isCheck == true ? redColor : lightGrey,
                              onPress: () async {
                                // hàm bất đồng bộ (async) và được định nghĩa như một lambda function.
                                if (isCheck != false) {
                                  controller.isLoading(true);
                                  try {
                                    await controller
                                        .sigupMethod(
                                            // Gọi phương thức sigupMethod từ đối tượng controller.
                                            context: context,
                                            email: emailController.text,
                                            password:
                                                passwordRetypeController.text)
                                        .then((value) {
                                      // Sau khi sigupMethod hoàn thành, phương thức .then được gọi với kết quả trả về từ sigupMethod.
                                      return controller.storeUserData(
                                          // storeUserData và hiển thị thông báo thành công.
                                          name: nameController.text,
                                          password: passwordController.text,
                                          email: emailController.text);
                                    }).then((value) {
                                      VxToast.show(context,
                                          msg: loggedInSuccessfully);
                                      Get.offAll(() => const HomeMain());
                                    });
                                  } on PlatformException catch (e) {
                                    auth.signOut();
                                    VxToast.show(Get.context!, msg: e.toString()); //  truyền Get.context! thay vì context để tránh việc truyền BuildContext qua các hàm bất đồng bộ.
                                    controller.isLoading(
                                        false); // Khi đăng kí lỗi, đổi lại nút button
                                  }
                                }
                              },
                              title: signup,
                              textColor: whiteColor,
                              width: context.screenWidth,
                              height: 50,
                              size: 18)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  15.heightBox,

                  // Text thoát
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text
                          .color(redColor)
                          .fontFamily(bold)
                          .make()
                          .onTap(() {
                        Get.back();
                      }),
                    ],
                  )
                ])
                    .box // tạo một hình chữ nhật (box)
                    .white
                    .rounded //cho các góc của hình chữ nhật trở nên bo tròn.
                    .padding(const EdgeInsets.all(
                        16)) // đặt khoảng cách (padding) cho hình chữ nhật.
                    .width(context.screenWidth -
                        70) // chiều rộng tùy thuộc vào màn hình (screenWidth) hiện tại và được giảm đi 70px.
                    .shadowSm // Đây là thuộc tính để đặt hiệu ứng bóng (shadow) cho hình chữ nhật.
                    .make()) // Phương thức xây dựng và trả về widget cuối cùng từ các thuộc tính đã được đặt trước đó.
          ],
        ),
      ),
    ));
  }
}
