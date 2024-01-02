import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/common/background_widget.dart';
import 'package:tvshop/common/loading_indicator.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/product_controller.dart';
import 'package:tvshop/services/firestore_services.dart';
import 'package:tvshop/view/category/details_item.dart';

class CategoryDetails extends StatelessWidget {
  // Truyền dữ liệu
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Khai báo biến dữ liệu lấy từ màn hình category screen
    var controller = Get.find<ProductController>();

    return backgroundWidget(
        child: Scaffold(
            appBar: AppBar(
                title: AutoSizeText(
              title!,
              style: const TextStyle(
                  fontSize: 18, color: whiteColor, fontFamily: semibold),
              maxLines: 1,
              overflow: TextOverflow
                  .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
            )),
            body: StreamBuilder(
                stream: FirestoreServices.getProducts(title),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "No products found!"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .size(20)
                          .make(),
                    );
                  } else {
                    // Lấy dữ liệu
                    var data = snapshot.data!.docs;

                    return Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: List.generate(
                                  controller.subCategories.length,
                                  (index) => Align(
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            "${controller.subCategories[index]}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: darkFontGrey,
                                                fontFamily: semibold),
                                            maxLines: 1,
                                            overflow: TextOverflow
                                                .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
                                          ))
                                      .box
                                      .white
                                      .roundedSM
                                      .size(120, 55)
                                      .padding(const EdgeInsets.all(8))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .make(),
                                ))),
                            20.heightBox,
                            Expanded(
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          mainAxisExtent: 250),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          data[index]['p_imgs'][0],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: AutoSizeText(
                                              "${data[index]['p_name']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: darkFontGrey,
                                                  fontFamily: semibold),
                                              maxLines: 1,
                                              overflow: TextOverflow
                                                  .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
                                            )),
                                        10.heightBox,
                                        "${data[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .fontFamily(semibold)
                                            .color(redColor)
                                            .size(16)
                                            .make(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .padding(const EdgeInsets.all(15))
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .roundedSM
                                        .shadowSm
                                        .make()
                                        .onTap(() {
                                      controller.checkFavorite(data[index]);
                                      Get.to(() => CategoryDetailsItem(
                                            title:
                                                "${data[index]['p_subcategory']}",
                                            data: data[index],
                                          ));
                                    });
                                  }),
                            )
                          ],
                        ));
                  }
                })));
  }
}
