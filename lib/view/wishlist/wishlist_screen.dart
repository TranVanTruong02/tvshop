import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tvshop/common/loading_indicator.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "Đơn hàng của bạn".text.white.size(18).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Không có đơn hàng nào."
                    .text
                    .size(18)
                    .fontFamily(semibold)
                    .color(fontGrey)
                    .make(),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
