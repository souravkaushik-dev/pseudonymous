import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../home/profile/features/models/app_user.dart';
import '../../post/models/post_models.dart';

class PublicProfileRepository {
  PublicProfileRepository._();

  static final _db = FirebaseFirestore.instance;

  static Stream<AppUser> user(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((doc) {
      return AppUser.fromMap(doc.data()!);
    });
  }

  static Stream<int> postCount(String uid) {
    return _db
        .collection("posts")
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
  
  static Stream<List<PostModel>> posts(String uid) {
    return _db
        .collection("posts")
        .where("uid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => PostModel.fromMap(
          e.data(),
          e.id,
        ),
      )
          .toList(),
    );
  }
}