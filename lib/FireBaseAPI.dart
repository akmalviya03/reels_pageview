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

  Stream<QuerySnapshot> getComments()  {
     return firestore.collection('Comments').snapshots();

    // .then((value) {
    // print(value.docs[0].data());
    // });
  }

  Stream<QuerySnapshot> getReplies({String parentDocumentId})  {
     return firestore.collection('Comments')
        .doc("Vtkg5wDlaNBXVlpNPGgx")
        .collection("Replies")
        .snapshots();

    // await firestore
    //     .collection('Comments')
    //     .doc("Vtkg5wDlaNBXVlpNPGgx")
    //     .collection("Replies")
    //     .get()
    //     .then((value) {
    //   print(value.docs[0].data());
    // });
  }

  Future<void> addReply(
      {String userName,
      String postId,
      String userAvatar,
      String userId,
      String reply,
      String documentId,
      Timestamp timestamp}) async {
    await firestore
        .collection("Comments")
        .doc(documentId)
        .collection("Replies")
        .doc()
        .set({
      "timestamp": timestamp,
      "postId": postId,
      "userId": userId,
      "userAvatar": userAvatar,
      "userName": userName,
      "reply": reply,
    });
  }
}
