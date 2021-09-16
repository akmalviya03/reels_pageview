import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addComment(
      {String userId,
      String postId,
      String comment,
      Timestamp timestamp}) async {
    await firestore.collection('Comments').doc().set({
      "userId": userId,
      "postId": postId,
      "comment": comment,
      "timestamp": timestamp
    });
  }

  Future<void> getComments() async {
    await firestore.collection('Comments').get().then((value) => {
          value.docs.forEach((element) {
            print(element.reference.id);
          })
        });
  }

  Future<void> addReply(
      {String userId, String reply, Timestamp timestamp}) async {
    await firestore
        .collection('Comments')
        .doc("mNgbfGGhH5Qo9SC5cUc2")
        .collection("Replies")
        .doc()
        .set({"userId": userId, "comment": reply, "Timestamp": timestamp});
  }
}
