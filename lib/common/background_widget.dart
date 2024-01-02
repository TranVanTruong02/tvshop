import 'package:tvshop/consts/consts.dart';

Widget backgroundWidget({Widget? child}) { // Đặt Widget? child trong dấu ngoặc nhọn {} để chỉ định rằng đó là một tham số tùy chọn (named parameter). Điều này cho phép bạn truyền giá trị vào tham số child khi gọi hàm backgroundWidget.
  return Container( // Widget Container được sử dụng để tạo một hộp chứa các widget khác và được tùy chỉnh thông qua thuộc tính decoration
    decoration: const BoxDecoration(
        image: DecorationImage( // DecorationImage là một lớp được sử dụng để định dạng hình ảnh trong BoxDecoration
            image: AssetImage(imgBackground), fit: BoxFit.fill)), //AssetImage là một lớp được sử dụng để tạo một hình ảnh từ một tệp nguồn được đặt trong thư mục assets của dự án
    child: child,
  );
}
