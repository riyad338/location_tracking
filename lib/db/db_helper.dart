import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracking_system/models/user_model.dart';

class DBHelper {
  static const _collectionWorker = 'Workers';
  static const _collectionLocation = 'Location';
  static const _collectionUser = 'Users';
  static const _collectiontypeAndImage = 'Type&Image';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addNewUser(UserModel userModel) {
    return _db
        .collection(_collectionUser)
        .doc(userModel.userId)
        .set(userModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLocation() =>
      _db.collection(_collectionLocation).snapshots();
  static Future<void> insertRole(String userId, String role) {
    return _db.collection(_collectionUser).doc(userId).update({
      'role': role,
    });
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails(
          String? userId) =>
      _db.collection(_collectionUser).doc(userId).get();
  static Future<void> updateUserProfile(
      String userId, String name, String phone) {
    return _db.collection(_collectionUser).doc(userId).update({
      'name': name,
      'phone': phone,
    });
  }

  static Future<void> updateImage(String userId, String image) {
    return _db
        .collection(_collectionUser)
        .doc(userId)
        .update({'picture': image});
  }

  static Future<bool> isUserExists(String userId) async {
    final userSnapshot =
        await _db.collection(_collectionUser).doc(userId).get();
    return userSnapshot.exists;
  }
}
