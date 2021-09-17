import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addComment(
      {String userId,
      String postId,
      String userName,
      String userAvatar,
      String comment,
      Timestamp timestamp}) async {
    await firestore.collection('Comments').doc().set({
      "timestamp": timestamp,
      "postId": postId,
      "userId": userId,
      "userAvatar": userAvatar,
      "userName": userName,
      "comment": comment,
    });
  }

  Stream<QuerySnapshot> getComments({String postId}) {
    return firestore
        .collection('Comments')
        .where("postId", isEqualTo: postId)
        .orderBy("timestamp")
        .snapshots();
  }

  Stream<QuerySnapshot> getReplies({String parentDocumentId}) {
    return firestore
        .collection('Comments')
        .doc(parentDocumentId)
        .collection("Replies")
        .snapshots();
  }

  Future<void> addReply(
      {String userName,
      String userAvatar,
      String userId,
      String reply,
      String parentDocumentId,
      Timestamp timestamp}) async {
    await firestore
        .collection("Comments")
        .doc(parentDocumentId)
        .collection("Replies")
        .doc()
        .set({
      "timestamp": timestamp,
      "userId": userId,
      "userAvatar": userAvatar,
      "userName": userName,
      "reply": reply,
    });
  }
}
