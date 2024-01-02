import 'package:firebase_auth/firebase_auth.dart';
import 'package:tvshop/common/logo_widget.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/view/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:tvshop/view/home/home_main.dart';

class StartScreen extends StatefulWidget {
  // Lớp StartScreen là một StatefulWidget, có nhiệm vụ xây dựng và quản lý trạng thái của màn hình này.
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // Create a method to change screen
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () { // Chờ 3s rồi đổi màn hình
      // Get.to(() => const LoginScreen()); // Use Getx
      auth.authStateChanges().listen((User? user) { // đối tượng đại diện cho hệ thống xác thực (authentication system) trong ứng dụng
        if (user == null && mounted) { // Nếu user là null và widget hiện tại (mounted) vẫn đang tồn tại (không bị hủy)
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const HomeMain());
        }
      });
    });
  }

  @override
  void initState() {
    // Thực hiện các tác vụ như khởi tạo trạng thái ban đầu của widget, đăng ký các lắng nghe sự kiện, tạo kết nối đến dữ liệu, và thực hiện các tác vụ khác liên quan đến trạng thái ban đầu của widget.
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Phương thức build của StartScreen được ghi đè để xây dựng cây widget cho màn hình.
    return Scaffold(
      // Scaffold là một widget trong Flutter cung cấp cấu trúc chung cho một màn hình, bao gồm thanh tiêu đề, nội dung và chân trang.
      backgroundColor: redColor,
      body: Center(
          // body: Center(...) là phần nội dung chính của Scaffold, nằm ở giữa màn hình và bao gồm một cột các widget.
          child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,
                  width:
                      300)), //  Đây là một widget hình ảnh được căn chỉnh ở góc trên bên trái của màn hình.
          20.heightBox, // Một widget hộp rỗng có chiều cao là 20 đơn vị.
          appLogo(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          2.heightBox,
          appversion.text.white.make(),
          const Spacer(), // Một widget để tạo khoảng trống linh hoạt giữa các thành phần.
          credits.text.white
              .fontFamily(semibold)
              .make(), // Một widget hiển thị các thông tin về tác giả hoặc nguồn gốc của ứng dụng với màu trắng và font chữ đậm.
          30.heightBox,
        ],
      )),
    );
  }
}
