import 'package:cloud_firestore/cloud_firestore.dart'; // cho phép chúng ta làm việc với cơ sở dữ liệu Cloud Firestore.
import 'package:firebase_auth/firebase_auth.dart'; // cho phép chúng ta xác thực người dùng và quản lý thông tin người dùng.

FirebaseAuth auth = FirebaseAuth
    .instance; // tạo một đối tượng auth từ lớp FirebaseAuth, cho phép chúng ta thực hiện các hoạt động liên quan đến xác thực người dùng.
FirebaseFirestore firestore = FirebaseFirestore
    .instance; // cho phép chúng ta thực hiện các hoạt động liên quan đến cơ sở dữ liệu Cloud Firestore.
User? currentUser = auth
    .currentUser; // tạo một biến currentUser để lưu trữ thông tin của người dùng hiện tại. Biến này sẽ trả về null nếu không có người dùng nào được xác thực.

// Collections
const usersCollection = "users";
const productsCollection = "products";
const cartCollection = "carts";
const chatCollection = "chats";
const messagesCollection = "messages";
const ordersCollection = "orders";
