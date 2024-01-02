import 'package:tvshop/common/button_featured.dart';
import 'package:tvshop/common/button_home.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/consts/lists.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: whiteColor,
              labelStyle: const TextStyle(fontFamily: regular, fontSize: 16),
              hintText: 'searchAnything',
              hintStyle: const TextStyle(color: textfieldGrey, fontSize: 16),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
                borderRadius: BorderRadius.circular(27.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
                borderRadius: BorderRadius.circular(27.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 19, 133, 226), width: 2),
                borderRadius: BorderRadius.circular(27.0),
              ),
            ),
          ),
          15.heightBox,
          Expanded(
              // Expanded được sử dụng để mở rộng widget con để lấp đầy không gian còn lại trong widget cha.
              child: SingleChildScrollView(
                  // Cuộn màn hình
                  physics:
                      const BouncingScrollPhysics(), //  khi bạn cuộn danh sách lên đến đỉnh hoặc kéo xuống đáy, BouncingScrollPhysics() sẽ tạo ra hiệu ứng nảy nhẹ, giúp người dùng nhận biết rõ rằng họ đã đạt đến đỉnh hoặc đáy của danh sách
                  child: Column(
                    children: [
                      // Swipers brands
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 200,
                          enlargeCenterPage: true,
                          itemCount: slidersList.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => buttomHome(
                                  width: context.screenWidth / 2.6,
                                  height: context.screenHeight * 0.1,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashSale,
                                )),
                      ),
                      20.heightBox,

                      // Swipers brands
                      VxSwiper.builder(
                          aspectRatio: 1 / 1,
                          autoPlay: true,
                          height: 200,
                          enlargeCenterPage: true,
                          itemCount: secondSlidersList.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => buttomHome(
                                  width: context.screenWidth / 3.5,
                                  height: context.screenHeight * 0.1,
                                  icon: index == 0
                                      ? icTopCategories
                                      : index == 1
                                          ? icBrands
                                          : icTopSeller,
                                  title: index == 0
                                      ? topCategories
                                      : index == 1
                                          ? brand
                                          : topSelles,
                                )),
                      ),

                      // featured categories
                      20.heightBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make(),
                      ),

                      20.heightBox,
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  3,
                                  (index) => Column(
                                        children: [
                                          buttonFeatured(
                                              title: featuredTitles1[index],
                                              icon: featuredImages1[index]),
                                          10.heightBox,
                                          buttonFeatured(
                                              title: featuredTitles2[index],
                                              icon: featuredImages2[index])
                                        ],
                                      )).toList())),

                      20.heightBox,
                      Container(
                        width: double
                            .infinity, // chiếm hết không gian ngang có sẵn.
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white
                                .fontFamily(bold)
                                .size(18)
                                .make(),
                            15.heightBox,
                            // Cuộn ngang
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
                                ))
                          ],
                        ),
                      ),

                      20.heightBox,
                      GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // vô hiệu hóa cuộn trang trong GridView.
                          shrinkWrap:
                              true, // cho phép GridView co dãn (shrink) theo nội dung bên trong
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 cột
                                  mainAxisSpacing:
                                      8, // khoảng cách dọc giữa các phần tử là 8 đơn vị
                                  crossAxisSpacing:
                                      8, // khoảng cách ngang giữa các phần tử là 8 đơn vị.
                                  mainAxisExtent:
                                      300), // Chiều cao của mỗi phần tử là 300.
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP5,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(), //
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
                                .padding(const EdgeInsets.all(15))
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .shadowSm
                                .make();
                          })
                    ],
                  )))
        ],
      )),
    );
  }
}
