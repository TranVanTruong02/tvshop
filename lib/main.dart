import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/view/flash/flash_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // nhiệm vụ của nó là đảm bảo rằng Flutter đã khởi tạo các binding cần thiết trước khi thực hiện bất kỳ công việc nào khác. Nó thường được gọi trước khi khởi tạo bất kỳ ứng dụng Flutter nào.
  await Firebase
      .initializeApp(); // Đây là một hàm bất đồng bộ (async) để khởi tạo Firebase
  // Khởi động chương trình
  runApp(const MyApp()); // Khởi động ứng dụng
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:
          false, //Đây là một thuộc tính của MaterialApp để kiểm soát việc hiển thị banner "DEBUG" trên giao diện người dùng trong chế độ debug.
      title: appname, // Đặt tên ứng dụng
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Màu nền
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: whiteColor, // Đặt màu cho icon appbar
            ),
            backgroundColor: Colors.transparent), // Chủ đề (màu) thanh Appbar
        fontFamily: regular,
      ),
      home: const StartScreen(),
    );
  }
}
