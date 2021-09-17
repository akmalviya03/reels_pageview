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
    @required this.userId,
    @required this.userAvatar,
    @required this.userName,
  })  : _controller = controller,
        super(key: key);

  final double fullVideoViewPortHeight;
  final AnimationController _controller;
  final String postId;
  final String userId;
  final String userAvatar;
  final String userName;

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

          //Show Comments When Comments Section is completely visible
          Visibility(
            visible: widget._controller.value == 1 ? true : false,
            child: Expanded(
              child: StreamBuilder(
                  stream: _firebaseApi.getComments(postId: widget.postId),
                  builder: (context, snapshotParentComment) {
                    if (snapshotParentComment.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshotParentComment.data.docs.length,
                        itemBuilder: (BuildContext context, int indexParent) {
                          return Column(
                            children: [
                              //Main Comment
                              CommentTitleWithAvatar(
                                userAvatar: snapshotParentComment
                                    .data.docs[indexParent]['userAvatar'],
                                userName: snapshotParentComment
                                    .data.docs[indexParent]['userName'],
                                commentOrReplyText: snapshotParentComment
                                    .data.docs[indexParent]['comment'],
                                //On Tap Of Reply Button
                                onTap: () {
                                  //To get document id use snapshot.data.docs[index].id
                                  myReplyProvider
                                      .updateUserNameAndParentDocumentId(
                                          userName: snapshotParentComment
                                                  .data.docs[indexParent][
                                              'userName'],
                                          parentDocumentId:
                                              snapshotParentComment
                                                  .data.docs[indexParent].id);

                                  _replyAnimationController.forward();
                                  myReplyProvider.updateAutoFocus(
                                      setAutoFocus: true);
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
                                    //TODO: Add Previous Replies Functionality
                                    //Replies
                                    StreamBuilder(
                                        stream: _firebaseApi.getReplies(
                                            parentDocumentId:
                                                snapshotParentComment
                                                    .data.docs[indexParent].id),
                                        builder: (context, snapshotReplies) {
                                          if (snapshotReplies.hasData) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshotReplies
                                                  .data.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int indexChild) {
                                                return CommentTitleWithAvatar(
                                                  userAvatar: snapshotReplies
                                                          .data.docs[indexChild]
                                                      ['userAvatar'],
                                                  userName: snapshotReplies
                                                          .data.docs[indexChild]
                                                      ['userName'],
                                                  commentOrReplyText:
                                                      snapshotReplies.data
                                                              .docs[indexChild]
                                                          ['reply'],
                                                  onTap: () {
                                                    myReplyProvider.updateUserNameAndParentDocumentId(
                                                        userName: snapshotReplies
                                                                    .data.docs[
                                                                indexChild]
                                                            ['userName'],
                                                        parentDocumentId:
                                                            snapshotParentComment
                                                                .data
                                                                .docs[
                                                                    indexParent]
                                                                .id);

                                                    _replyAnimationController
                                                        .forward();

                                                    myReplyProvider
                                                        .updateAutoFocus(
                                                            setAutoFocus: true);

                                                    focusNodeReply
                                                        .requestFocus();
                                                  },
                                                );
                                              },
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
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
                          title: Consumer<ReplyProvider>(
                              builder: (context, replyProvider, child) {
                            return Text(
                              'Replying To ' + replyProvider.getUserName(),
                              style: TextStyle(fontSize: 14),
                            );
                          }),

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
                      userAvatar: widget.userAvatar,
                      hintText: "Add a comment...",
                      onTap: () async {
                        if (_commentsTextEditingController.text.length != 0) {
                          await _firebaseApi.addComment(
                            userId: widget.userId,
                            postId: widget.postId,
                            userAvatar: widget.userAvatar,
                            userName: widget.userName,
                            comment: _commentsTextEditingController.text,
                            timestamp: Timestamp.now(),
                          );
                          _commentsTextEditingController.clear();
                        }
                      },
                    ),

                    //Add a Reply Text Field & Post Button
                    AddReplyOrCommentAvatarTextFiledPostButton(
                        visible: _replyAnimationController.value <= 0.01
                            ? false
                            : true,
                        focusNode: focusNodeReply,
                        textEditingController: _repliesTextEditingController,
                        userAvatar: widget.userAvatar,
                        hintText: "Add a reply...",
                        onTap: () {
                          if (_repliesTextEditingController.text.length != 0) {
                            _firebaseApi.addReply(
                                timestamp: Timestamp.now(),
                                parentDocumentId:
                                    myReplyProvider.getParentDocumentId(),
                                userId: widget.userId,
                                userAvatar: widget.userAvatar,
                                userName: widget.userName,
                                reply: _repliesTextEditingController.text);
                          }
                          _replyAnimationController.reverse(from: 1);
                          _repliesTextEditingController.clear();
                        }),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

// InkWell(
//   onTap: () {},
//   child: Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Row(
//       children: [
//         Container(
//           width:
//               MediaQuery.of(context).size.width * 0.1,
//           height: MediaQuery.of(context).size.width *
//               0.004,
//           color: Colors.black,
//         ),
//         SizedBox(
//           width: 4,
//         ),
//         Text(
//           'Show previous replies',
//           style: TextStyle(
//               fontSize: 12,
//               color: Colors.black,
//               fontWeight: FontWeight.w600),
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(
//   height: 4,
// ),
