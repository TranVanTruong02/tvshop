import 'dart:io';

import 'package:get/get.dart';
import 'package:tvshop/common/background_widget.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/common/custom_textfield.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/profile_controller.dart';
import 'package:tvshop/view/profile/profile_screen.dart';

class ProfileEdit extends StatelessWidget {
  final dynamic data;
  const ProfileEdit({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // Biến dữ liệu
    var controller = Get.find<ProfileController>();

    return backgroundWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: "Thay đổi thông tin"
                  .text
                  .white
                  .size(20)
                  .fontFamily(semibold)
                  .make(),
            ),
            body: Obx(
              () => Column(mainAxisSize: MainAxisSize.min, children: [
                // Nếu như dữ liệu đường dẫn ảnh và đường dẫn controller đều trống
                data['u_img_url'] == '' && controller.profileImgPath.isEmpty
                    // Nếu đúng (dùng ảnh mặc định)
                    ? Image.asset(
                        imgProfile2,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    // Nếu sai
                    : data['u_img_url'] != '' &&
                            controller.profileImgPath
                                .isEmpty // Nếu như có dữ liệu nhưng đường dẫn trống
                        ? Image.network(
                            data['u_img_url'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                5.heightBox,
                customButton(
                  width: 80,
                  height: 30,
                  color: redColor,
                  onPress: () {
                    controller.changImage(context);
                  },
                  title: "Change",
                  textColor: lightGrey,
                  size: 14,
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                  title: name,
                  hint: nameHint,
                  controller: controller.nameController,
                  isPass: false,
                ),
                5.heightBox,
                customTextField(
                    title: oldPassword,
                    hint: oldPasswordEdit,
                    controller: controller.passwordOldController,
                    isPass: true),
                5.heightBox,
                customTextField(
                    title: "newPassword",
                    hint: "newPasswordEdit",
                    controller: controller.passwordNewController,
                    isPass: true,),
                20.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : customButton(
                        width: context.screenWidth,
                        height: 40,
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);
                          // Đổi ảnh đại diện, nếu đường dẫn ảnh trống
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller
                                .uploadProfileImage(); // Thì Update ảnh và lấy đường dẫn
                          } else {
                            // nếu đường dẫn có dữ liệu, đổi lại ảnh trong controller
                            controller.profileImgLink = data['u_img_url'];
                          }

                          // Đổi mật khẩu
                          if (data['u_password'] ==
                              controller.passwordOldController.text) {
                            if (controller.passwordOldController.text !=
                                controller.passwordNewController.text) {
                              // Đổi lại mật khẩu trên máy
                              await controller.changeAuthPassword(
                                  email: data['u_email'],
                                  oldpassword:
                                      controller.passwordOldController.text,
                                  newpassword:
                                      controller.passwordNewController.text);
                              await controller.updateProfie(
                                  name: controller.nameController.text,
                                  password:
                                      controller.passwordNewController.text,
                                  imgUrl: controller.profileImgLink);
                              VxToast.show(context!,
                                  msg: "Cập nhật thành công!");
                              await Get.to(() => const ProfileScreen());
                            } else {
                              VxToast.show(context!,
                                  msg: "Mật khẩu mới phải khác mật khẩu cũ");
                              controller.isLoading(false);
                            }
                          } else {
                            VxToast.show(context!,
                                msg: "Mật khẩu không chính xác");
                            controller.isLoading(false);
                          }
                        },
                        title: "Save",
                        textColor: lightGrey,
                        radius: 10),
              ])
                  .box
                  .white
                  .padding(const EdgeInsets.all(15))
                  .margin(const EdgeInsets.only(top: 50, left: 20, right: 20))
                  .roundedSM
                  .shadowSm
                  .make(),
            )));
  }
}
