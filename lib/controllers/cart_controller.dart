import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/controllers/home_controller.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  // Shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  // 'late' sẽ được khởi tạo sau khi được khai báo.
  // "dynamic" là một kiểu dữ liệu đặc biệt cho phép biến chứa bất kỳ loại dữ liệu nào.
  late dynamic productSnapshot;
  var products = [];
  var placingOrder = false.obs;

  // Tính tổng tiền giỏ hàng
  caculatate(data) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value += int.parse(data[i]['c_totalprice'].toString());
    }
  }

  // Chọn Radio
  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  // Đơn hàng
  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'o_code': "12998553",
      'o_date': FieldValue.serverTimestamp(),
      'user_id': currentUser!.uid,
      'o_u_name': Get.find<HomeController>().username,
      'o_u_email': currentUser!.email,
      'o_address': addressController.text,
      'o_city': cityController.text,
      'o_state': stateController.text,
      'o_postal_code': postalCodeController.text,
      'o_phone': phoneController.text,
      'o_shipping_method': "Chưa thanh toán",
      'o_payment_method': orderPaymentMethod,
      'o_placed': true, // Đã đặt hàng
      'o_confirmed': false, // Đã xác nhận
      'o_delivered': false, // Đã giao hàng
      'o_on_delivered': false, // Đã nhận hàng
      'o_total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'c_p_name': productSnapshot[i]['c_p_name'],
        'c_p_img': productSnapshot[i]['c_p_img'],
        'c_totalprice': productSnapshot[i]['c_totalprice'],
        'c_p_color': productSnapshot[i]['c_p_color'],
        'c_quantity': productSnapshot[i]['c_quantity'],
        'vendor_id': productSnapshot[i]['vendor_id'],
      });
    }
  }

  // Xóa sản phẩm trong giỏ hàng sau khi mua
  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
