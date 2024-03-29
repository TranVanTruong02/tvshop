import 'package:tvshop/consts/consts.dart';

Widget buttonFeatured({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(200)
      .white
      .margin(const EdgeInsets.symmetric(horizontal: 5))
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make();
}
