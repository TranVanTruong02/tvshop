import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tvshop/consts/consts.dart';
import 'package:tvshop/models/category_model.dart';

class ProductController extends GetxController {
  var quantity = 0
      .obs; //  tạo ra một đối tượng có khả năng theo dõi và thông báo về sự thay đổi trong giá trị của nó.
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var isFavorite = false.obs;

  // Lớp này sẽ được sử dụng để quản lý trạng thái và logic liên quan đến sản phẩm trong ứng dụng.
  // Khở tạo mảng
  var subCategories =
      []; // Dòng này khởi tạo một biến subCategories là một mảng rỗng.

  getSubCategories(context, title) async {
    // Làm rỗng mảng trước mỗi lần chạy
    subCategories.clear();
    var data = await rootBundle.loadString(
        "lib/services/category_model.json"); // Dòng này sử dụng rootBundle để tải nội dung của tệp category_model.json từ đường dẫn lib/services/category_model.json.
    var decode = categoryModelFromJson(
        data); // giải mã nội dung data thành một đối tượng decode của lớp CategoryModel.
    var filter = decode.categories
        .where((element) => element.name == title)
        .toList(); // Kết quả được gán cho biến filter dưới dạng một danh sách.
    if (filter.isNotEmpty && filter[0].subcategory.isNotEmpty) {
      for (var e in filter[0].subcategory) {
        // duyệt qua từng phần tử trong danh sách con (subcategory) của phần tử đầu tiên trong danh sách filter
        subCategories.add(e);
      }
    } else {
      VxToast.show(context, msg: "Lỗi dữ liệu");
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  // Giảm số lượng
  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  // Tính tổng tiền
  caculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  // add to cart
  addToCart({context, name, img, seller, color, quantity, totalprice, vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      'c_p_name': name,
      'c_p_img': img,
      'c_p_seller': seller,
      'c_p_color': color,
      'c_quantity': quantity,
      'c_totalprice': totalprice,
      'user_id': currentUser!.uid,
      'vendor_id': vendorId,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  // Đặt lại giá trị sau khi sử dụng
  resetValues() {
    quantity.value = 0;
    colorIndex.value = 0;
    totalPrice.value = 0;
  }

  // Thích sản phẩm
  addToWishlist(context, docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFavorite(true);
    VxToast.show(context, msg: addedToWishlist);
  }

  removeFromWishlist(context, docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFavorite(false);
    VxToast.show(context, msg: removedFavorite);
  }

  // Kiểm tra xem người dùng có sản phẩm đó không
  checkFavorite(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFavorite(true);
    } else {
      isFavorite(false);
    }
  }
}
