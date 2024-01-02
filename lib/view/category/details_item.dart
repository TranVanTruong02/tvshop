import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/custom_button.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/consts/lists.dart';
import 'package:tvshop/controllers/product_controller.dart';
import 'package:tvshop/view/chat/chat_screen.dart';

class CategoryDetailsItem extends StatelessWidget {
  final String? title;
  final dynamic data;
  const CategoryDetailsItem({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    // Biến dữ liệu
    var controller = Get.find<ProductController>();

    return PopScope(
      // Điều hướng trên điện thoại
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          controller.resetValues();
          // Nếu canPop là true
          return;
        }
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              // Sự kiện nút trở về
              onPressed: () {
                controller.resetValues();
                Get.back(); // quay lại màn hình trước đó
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: darkFontGrey,
          title: AutoSizeText(
            title!,
            style: const TextStyle(
                fontSize: 18, color: whiteColor, fontFamily: semibold),
            maxLines: 1,
            overflow: TextOverflow
                .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFavorite.value) {
                      controller.removeFromWishlist(context, data.id);
                    } else {
                      controller.addToWishlist(context, data.id);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFavorite.value ? redColor : whiteColor,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VxSwiper.builder(
                              autoPlay: true,
                              height: 350,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              itemCount: data['p_imgs'].length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  data['p_imgs'][index],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }),
                          10.heightBox,
                          title!.text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          VxRating(
                            value: double.parse(data['p_rating']),
                            isSelectable: false,
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            count: 5,
                            maxRating: 5,
                            size: 25,
                          ),
                          10.heightBox,
                          "${data['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Seller"
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .size(18)
                                      .make(),
                                  "${data['p_seller']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make(),
                                ],
                              )),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: darkFontGrey,
                                ),
                              ).onTap(() {
                                // Sự kiện messager
                                Get.to(() => const ChatScreen(), arguments: [
                                  data['p_seller'],
                                  data['vendor_id']
                                ]);
                              })
                            ],
                          )
                              .box
                              .height(60)
                              .padding(
                                  const EdgeInsets.symmetric(horizontal: 16))
                              .color(textfieldGrey)
                              .make(),
                          // Color section
                          20.heightBox,
                          Obx(() => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: "Color: "
                                            .text
                                            .color(textfieldGrey)
                                            .make(),
                                      ),
                                      Row(
                                          children: List.generate(
                                              data['p_colors'].length,
                                              (index) => Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      VxBox()
                                                          .size(40, 40)
                                                          .roundedFull
                                                          .color(Color(data[
                                                                      'p_colors']
                                                                  [index])
                                                              .withOpacity(1.0))
                                                          .margin(
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      4))
                                                          .make()
                                                          .onTap(() {
                                                        controller
                                                            .changeColorIndex(
                                                                index);
                                                      }),
                                                      Visibility(
                                                          visible: index ==
                                                              controller
                                                                  .colorIndex
                                                                  .value,
                                                          child: const Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  )))
                                    ],
                                  ),

                                  //Quantity row
                                  10.heightBox,
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: "Quantity: "
                                            .text
                                            .color(textfieldGrey)
                                            .make(),
                                      ),
                                      Obx(() => Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .decreaseQuantity();
                                                    controller
                                                        .caculateTotalPrice(
                                                            int.parse(data[
                                                                'p_price']));
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                              controller.quantity.value.text
                                                  .size(16)
                                                  .color(darkFontGrey)
                                                  .fontFamily(bold)
                                                  .make(),
                                              IconButton(
                                                  onPressed: () {
                                                    controller.increaseQuantity(
                                                        int.parse(data[
                                                            'p_quantity']));
                                                    controller
                                                        .caculateTotalPrice(
                                                            int.parse(data[
                                                                'p_price']));
                                                  },
                                                  icon: const Icon(Icons.add)),
                                              15.widthBox,
                                              "${data['p_quantity']} available"
                                                  .text
                                                  .color(textfieldGrey)
                                                  .make(),
                                            ],
                                          ))
                                    ],
                                  ),

                                  //total row
                                  10.heightBox,
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: "Tổng: "
                                            .text
                                            .color(textfieldGrey)
                                            .make(),
                                      ),
                                      "${controller.totalPrice.value}"
                                          .numCurrency
                                          .text
                                          .size(16)
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make()
                                    ],
                                  )
                                ],
                              )
                                  .box
                                  .white
                                  .padding(const EdgeInsets.all(8))
                                  .make()),

                          // Description
                          10.heightBox,
                          "Mô tả"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          "${data['p_desc']}"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),

                          // Listview
                          10.heightBox,
                          ListView(
                            shrinkWrap: true,
                            children: List.generate(
                                categoryDetailsItemButton.length,
                                (index) => ListTile(
                                      title: categoryDetailsItemButton[index]
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      trailing: const Icon(Icons.arrow_forward),
                                    )),
                          ),

                          15.heightBox,
                          productsYouMayLike.text
                              .size(10)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),

                          // List product
                          10.heightBox,
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  6,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4/64GB"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$600"
                                          .text
                                          .fontFamily(semibold)
                                          .color(redColor)
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .rounded
                                      .padding(const EdgeInsets.all(8))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 5))
                                      .shadowSm
                                      .make(),
                                ),
                              )),
                        ],
                      ),
                    ))),
            15.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customButton(
                    color: golden,
                    onPress: () async {
                      if (controller.quantity.value > 0) {
                        await controller.addToCart(
                          context: context,
                          name: data['p_name'],
                          img: data['p_imgs'][0],
                          seller: data['p_seller'],
                          color: data['p_colors'][controller.colorIndex.value],
                          quantity: controller.quantity.value,
                          totalprice: controller.totalPrice.value,
                          vendorId: data['vendor_id'],
                        );
                        VxToast.show(context, msg: addedToCart);
                      } else {
                        VxToast.show(context, msg: "vui lòng chọn số lượng sản phẩm");
                      }
                    },
                    title: "Add to Cart",
                    textColor: whiteColor,
                    radius: 10,
                    width: 160,
                    height: 50,
                    size: 16),
                customButton(
                    color: redColor,
                    onPress: () {},
                    title: "By Now",
                    textColor: whiteColor,
                    radius: 10,
                    width: 160,
                    height: 50,
                    size: 16),
              ],
            ),
            25.heightBox
          ],
        ),
      ),
    );
  }
}
