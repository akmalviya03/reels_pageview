import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'FireBaseAPI.dart';

class CommentTitleWithAvatar extends StatelessWidget {
  const CommentTitleWithAvatar({
    Key key,@required this.firebaseApi,@required this.replyAnimationController,@required this.focusNodeReply,
  }) : super(key: key);

  final FirebaseApi firebaseApi;
  final AnimationController replyAnimationController;
  final FocusNode focusNodeReply;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 8,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      //UserImage
      leading: CircleAvatar(
        foregroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80'),
      ),
      // Add a comment
      title: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vrushank Shah',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            ReadMoreText(
              'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
              trimLength: 100,
              lessStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff396BBC),
                  fontWeight: FontWeight.w600),
              moreStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff396BBC),
                  fontWeight: FontWeight.w600),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  '1d ago',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    replyAnimationController.forward();
                    replyAnimationController.value <= 0.1 ? focusNodeReply.requestFocus() : null;
                    //firebaseApi.addReply(userId: "Someone",reply: "This is my first reply");
                  },
                  child: Text(
                    'Reply',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff396BBC),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Post Button
    );
  }
}