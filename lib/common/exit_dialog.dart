import 'package:flutter/services.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/consts/consts.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        confirm.text.size(22).color(blue).fontFamily(bold).make(),
        15.heightBox,
        areYouSureYouWantToExit.text
            .size(16)
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
                    // Thoát
                    color: redColor,
                    onPress: () {
                      SystemNavigator.pop(); // Yêu cầu hệ thống đóng ứng dụng
                    },
                    title: yes,
                    textColor: whiteColor,
                    width: 100,
                    height: 40,
                    size: 16)
                .box
                .width(100)
                .make(),
            customButton(
                    // Hủy thoát
                    color: redColor,
                    onPress: () {
                      Navigator.pop(
                          context); // tìm kiếm màn hình trước đó trong ngăn xếp điều hướng, đưa người dùng trở lại màn hình trước đó.
                    },
                    title: no,
                    textColor: whiteColor,
                    width: 100,
                    height: 40,
                    size: 16)
                .box
                .width(100)
                .make(),
          ],
        )
      ],
    ).box.white.padding(const EdgeInsets.all(20)).roundedSM.make(),
  );
}
