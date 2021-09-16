import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/replyProvider.dart';
import 'package:reels_pageview/scrollProvider.dart';
import 'AddReplyOrCommentAvatarTextFiledPostButton.dart';
import 'CommentTitleWithAvatar.dart';
import 'FireBaseAPI.dart';

class AllComments extends StatefulWidget {
  AllComments({
    Key key,
    @required this.fullVideoViewPortHeight,
    @required AnimationController controller,
    @required this.postId,
  })  : _controller = controller,
        super(key: key);

  final String postId;
  final double fullVideoViewPortHeight;
  final AnimationController _controller;

  @override
  _AllCommentsState createState() => _AllCommentsState();
}

class _AllCommentsState extends State<AllComments>
    with SingleTickerProviderStateMixin {
  final TextEditingController _commentsTextEditingController =
      TextEditingController();
  final TextEditingController _repliesTextEditingController =
      TextEditingController();
  final FirebaseApi _firebaseApi = new FirebaseApi();
  AnimationController _replyAnimationController;
  FocusNode focusNodeReply;
  FocusNode focusNodeComment;

  @override
  void initState() {
    super.initState();
    focusNodeReply = FocusNode();
    focusNodeComment = FocusNode();
    focusNodeReply.unfocus();
    focusNodeComment.unfocus();
    _replyAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _replyAnimationController.dispose();
    focusNodeReply.dispose();
    focusNodeComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myScrollProvider =
        Provider.of<ScrollProvider>(context, listen: false);
    final myReplyProvider = Provider.of<ReplyProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      height: widget.fullVideoViewPortHeight * 0.6 * widget._controller.value,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Heading Comments With IconButton
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            title: Text(
              'Comments',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                widget._controller.reverse(from: 1);
                focusNodeReply.unfocus();
                focusNodeComment.unfocus();
                myReplyProvider.updateAutoFocus(setAutoFocus: false);
                myScrollProvider.updateScrollable(scrollValue: true);
              },
              icon: Icon(
                Icons.close,
              ),
              color: Colors.black,
              tooltip: 'Close',
            ),
          ),

          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    //Main Comment
                    CommentTitleWithAvatar(
                      userAvatar:
                          'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                      userName: "Vrushank Shah",
                      comment: "Some comment",
                      //On Tap Of Reply Button
                      onTap: () {
                        //To get document id use snapshot.data.docs[index].id
                        myReplyProvider.updateUserName(userName: "Abhishak");
                        _replyAnimationController.forward();
                        focusNodeReply.requestFocus();
                      },
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //Show Previous Replies Button & Replies
                    Padding(
                      //padding calculated by Avatar Diameter + total padding around avatar
                      //40 + 16
                      padding: EdgeInsets.only(left: 56),
                      child: Column(
                        children: [
                          //Show Previous Replies Button
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width *
                                        0.004,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Show previous replies',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          //Replies
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return CommentTitleWithAvatar(
                                comment: "Some comment",
                                userAvatar:
                                    'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                                userName: "Vrushank Shah",
                                onTap: () {
                                  myReplyProvider.updateUserName(
                                      userName: "Vrushank Shah");
                                  _replyAnimationController.forward();
                                  focusNodeReply.requestFocus();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          //Replying To User Alert With TextField For Comment And Reply
          AnimatedBuilder(
              animation: _replyAnimationController,
              builder: (BuildContext context, Widget child) {
                return Column(
                  children: [
                    //Replying To User Alert
                    Offstage(
                      //Hiding Alert When Value is Less Than 0.01
                      offstage: _replyAnimationController.value <= 0.01
                          ? true
                          : false,
                      child: Align(
                        heightFactor: _replyAnimationController.value,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          // Add a comment
                          title: Text(
                            'Replying To ' + myReplyProvider.getUserName(),
                            style: TextStyle(fontSize: 14),
                          ),
                          // Post Button
                          trailing: IconButton(
                            onPressed: () {
                              _replyAnimationController.reverse(from: 1);
                              focusNodeComment.requestFocus();
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                            color: Colors.black,
                            tooltip: 'Close',
                          ),
                        ),
                      ),
                    ),

                    // Add a Comment Text field & Post Button
                    AddReplyOrCommentAvatarTextFiledPostButton(
                      visible: _replyAnimationController.value <= 0.01
                          ? true
                          : false,
                      focusNode: focusNodeComment,
                      textEditingController: _commentsTextEditingController,
                      userAvatar:
                          'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                      hintText: "Add a comment...",
                      onTap: () async {
                        // if (_commentsTextEditingController.text.length != 0) {
                        //   await _firebaseApi.addComment(
                        //     userId: "UserId001",
                        //     postId: "Post001",
                        //     userAvatar:
                        //         'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                        //     userName: "Vrushank",
                        //     comment: _commentsTextEditingController.text,
                        //     timestamp: Timestamp.now(),
                        //   );
                        //   _commentsTextEditingController.clear();
                        // }
                      },
                    ),

                    //AddReply
                    AddReplyOrCommentAvatarTextFiledPostButton(
                      visible: _replyAnimationController.value <= 0.01
                          ? false
                          : true,
                      focusNode: focusNodeReply,
                      textEditingController: _repliesTextEditingController,
                      userAvatar:
                          'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                      hintText: "Add a reply...",
                      onTap: () {
                        //Document Id
                        //Vtkg5wDlaNBXVlpNPGgx
                        // _firebaseApi.addReply(
                        //     timestamp: Timestamp.now(),
                        //     documentId: "Vtkg5wDlaNBXVlpNPGgx",
                        //     userId: "UserId001",
                        //     postId: "Post001",
                        //     userAvatar:
                        //         'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                        //     userName: "Vrushank",
                        //     reply: "My First Reply");
                        // _replyAnimationController.reverse(from: 1);
                      },
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
