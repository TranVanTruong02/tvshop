import 'package:tvshop/consts/consts.dart';

Widget placedDetails(
    {required title1,
    required title2,
    required data1,
    required data2,
    double width1 = 60,
    double width2 = 60}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1
                .toString()
                .text
                .size(14)
                .fontFamily(bold)
                .color(darkFontGrey)
                .make(),
            "$data1".text.size(14).fontFamily(semibold).color(fontGrey).make(),
          ],
        ).box.width(width1).make(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              title2
                  .toString()
                  .text
                  .size(14)
                  .fontFamily(bold)
                  .color(darkFontGrey)
                  .make(),
              "$data2"
                  .text
                  .size(14)
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .make(),
            ],
          ).box.width(width2).make(),
        ),
      ],
    ),
  );
}
