import 'package:tvshop/consts/consts.dart';

Widget buttonProfile({width, height, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.size(14).color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(height).padding(const EdgeInsets.all(4)).make();
}