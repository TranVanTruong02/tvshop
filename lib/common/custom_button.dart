import 'package:tvshop/consts/consts.dart';

Widget customButton({double? width = 100, double? height = 100, color, onPress, String? title, textColor, double? radius = 5, double? size = 20}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!)
        ),
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
        minimumSize: Size(width!, height!),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).size(size).make(),
      );
}
