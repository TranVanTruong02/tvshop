import 'package:tvshop/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Thực hiện custom tiêu đề
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      // Thực hiện custom TextField
      TextFormField(
        // Ẩn giá trị của một trường văn bản (text field) như mật khẩu hoặc thông tin nhạy cảm khác.
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: italic,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 19, 133, 226), width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
