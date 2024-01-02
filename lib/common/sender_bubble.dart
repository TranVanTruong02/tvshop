import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['m_created_on'] == null ? DateTime.now() : data['m_created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: data['uid'] == currentUser!.uid
          ? const EdgeInsets.only(left: 100, bottom: 8)
          : const EdgeInsets.only(right: 100, bottom: 8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
        borderRadius: data['uid'] == currentUser!.uid
            ? const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15))
            : const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['m_message']}".text.white.size(18).make(),
          time.text.color(whiteColor.withOpacity(0.5)).size(12).make(),
        ],
      ),
    ),
  );
}
