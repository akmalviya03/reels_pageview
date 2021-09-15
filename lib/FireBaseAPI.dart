import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addComment(
      {String userId, String postId, String comment}) async {
    await firestore
        .collection('Comments')
        .doc()
        .set({"userId": userId, "postId": postId, "comment": comment});
  }
}
