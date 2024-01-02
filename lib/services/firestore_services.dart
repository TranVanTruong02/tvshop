import 'package:tvshop/consts/consts.dart';

class FirestoreServices {
  // Lấy dữ liệu người dùng dựa trên uid (User ID).
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('user_id', isEqualTo: uid)
        .snapshots();
  }

  // Get product
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  // get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("user_id", isEqualTo: uid)
        .snapshots();
  }

  // delete cart
  static deleteCart(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // Get all chart messager
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('m_created_on', descending: false)
        .snapshots();
  }

  // get All order user
  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('user_id', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // get All wishlist user
  static getAllWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  // get All order user
  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('ch_fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }
}
