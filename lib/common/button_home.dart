import 'package:tvshop/consts/consts.dart';

Widget buttomHome({width, height, icon, String? title, onPress}) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Căn chỉnh các phần tử ở giữa
      children: [
        Image.asset(icon, width: 26),
        10.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
