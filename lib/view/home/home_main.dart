import 'package:get/get.dart';
import 'package:tvshop/common/exit_dialog.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/home_controller.dart';
import 'package:tvshop/view/cart/cart_screen.dart';
import 'package:tvshop/view/category/category_screen.dart';
import 'package:tvshop/view/home/home_screen.dart';
import 'package:tvshop/view/profile/profile_screen.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    // Các thành phần cửa
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    // Các thành phần của BottomNavigationBar
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: profile)
    ];

    return PopScope( // kiểm soát cách xử lý nút quay lại và các cử chỉ điều hướng khác trong cây widget con của nó.
        canPop: false, // người dùng sẽ không thể quay lại màn hình trước đó bằng nút quay lại hoặc cử chỉ hệ thống.
        onPopInvoked: (didPop) async {
          if (didPop) { // Nếu canPop là true
            return;
          }
          showDialog(
              barrierDismissible: false, // ngăn người dùng tắt hộp thoại bằng cách chạm vào bên ngoài nó.
              context: context,
              builder: (context) => exitDialog(context));
        },
        child: Scaffold(
          body: Column(
            children: [
              //  Expanded là một widget được sử dụng để mở rộng và điều chỉnh kích thước của widget con của nó trong một Flex container như Row hoặc Column.
              Obx(() => Expanded(
                  // Đây là một widget Obx (observable widget) trong GetX, nó sẽ theo dõi sự thay đổi của controller.
                  child: navBody.elementAt(controller.currentNavIndex.value))),
            ],
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value) {
                controller.currentNavIndex.value = value;
              },
            ),
          ),
        ));
  }
}
