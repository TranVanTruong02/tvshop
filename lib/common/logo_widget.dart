import 'package:tvshop/consts/consts.dart';

Widget appLogo() { // Đây là khai báo một hàm widget có tên là AppLogo.
  return Image.asset(icAppLogo) // Đoạn mã trả về một widget Image.asset để hiển thị hình ảnh từ tài nguyên trong dự án
      .box // .box: Đây là một phương thức mở rộng (extension method) được áp dụng cho widget Image.asset. Nó chuyển đổi widget thành một widget container (Container) để có thể áp dụng các thuộc tính và phương thức khác.
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded // .rounded: Đây là một phương thức mở rộng để làm tròn các góc của widget container.
      .make(); // .make(): Đây là một phương thức mở rộng để tạo ra widget cuối cùng.
}
