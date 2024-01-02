import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/common/custom_textfield.dart';
import 'package:tvshop/common/logo_widget.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/common/background_widget.dart';
import 'package:tvshop/consts/lists.dart';
import 'package:get/get.dart';
import 'package:tvshop/controllers/auth_controller.dart';
import 'package:tvshop/view/auth/signup_screen.dart';
import 'package:tvshop/view/home/home_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khai báo biến dữ liệu
    var controller = Get.put(AuthController());

    return backgroundWidget(
        child: Scaffold(
      resizeToAvoidBottomInset:
          false, // Khi resizeToAvoidBottomInset được đặt là false, Scaffold sẽ không điều chỉnh kích thước của nội dung bên trong khi bàn phím xuất hiện.
      body: Center(
        child: Column(
          // Column chứa nhiều widget con khác nhau
          children: [
            // Logo
            (context.screenHeight * 0.1)
                .heightBox, // Tạo một hộp (Box) có chiều cao dựa trên chiều cao của màn hình. Giá trị này được nhân với 0.1 để lấy 10% của chiều cao màn hình.
            appLogo(), // Logo: là một widget tuỳ chỉnh
            15.heightBox,

            "Log in to $appname".text.fontFamily(bold).white.size(22).make(),
            20.heightBox,

            // TextField
            Obx(() => Column(
                  children: [
                    // Sử dụng custom TextField
                    customTextField(
                        title: "Email",
                        hint: "trantruong02@gmail.com",
                        isPass: false,
                        controller: controller.emailController),
                    5.heightBox,
                    customTextField(
                        title: "Password",
                        hint: "*****",
                        isPass: true,
                        controller: controller.passwordController),

                    // Sử dụng textButton
                    Align(
                      // căn chỉnh widget con dọc theo trục ngang (horizontal) hoặc dọc theo trục dọc (vertical) của không gian mẹ.
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPassword.text.make()),
                    ),

                    // Button Login
                    5.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : customButton(
                                color: redColor,
                                onPress: () async {
                                  controller.isLoading(
                                      true); // Nút button đổi thành CircularProgressIndicator
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context,
                                          msg: loggedInSuccessfully);
                                      Get.offAll(() => const HomeMain());
                                    } else {// nếu lỗi nút button sẽ hiển thị lại
                                      controller.isLoading(false);
                                    }
                                  });
                                },
                                title: login,
                                textColor: whiteColor,
                                width: context.screenWidth,
                                height: 50,
                                size: 18)
                            .box
                            .width(context.screenWidth - 50)
                            .make(),

                    5.heightBox,
                    createNewAccount.text.color(fontGrey).size(14).make(),
                    5.heightBox,

                    // Button Sign in
                    5.heightBox,
                    customButton(
                            color: lightGrey,
                            onPress: () {
                              Get.to(() => const SignupScreen());
                            },
                            title: signup,
                            textColor: redColor,
                            width: context.screenWidth,
                            height: 50,
                            size: 18)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),

                    15.heightBox,
                    loginWith.text.color(fontGrey).size(14).make(),
                    10.heightBox,

                    // Login Google, Facebook
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                  )))),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make()),
          ],
        ),
      ),
    ));
  }
}
