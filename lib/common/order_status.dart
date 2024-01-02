import 'package:tvshop/consts/consts.dart';

Widget orderStatus({
  required icon,
  required color,
  required title,
  required showDone,
  double width = 80,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 5, 15, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color)
                .box
                .border(color: color)
                .size(45, 45)
                .roundedSM
                .make(),
          ],
        ).box.width((width - 10) * 0.2).make(),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: textfieldGrey, height: 2, endIndent: 10),
          ],
        ).box.width((width - 10) * 0.45).make(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                "$title"
                    .text
                    .size(14)
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
                5.widthBox,
                showDone
                    ? const Icon(
                        Icons.done_rounded,
                        color: redColor,
                      )
                    : Container()
              ])
            ],
          ).box.width((width - 10) * 0.35).make(),
        ),
      ],
    ),
  );
}
