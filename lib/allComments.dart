import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/scrollProvider.dart';
import 'CommentTitleWithAvatar.dart';
import 'FireBaseAPI.dart';

class AllComments extends StatefulWidget {
  AllComments({
    Key key,
    @required this.fullVideoViewPortHeight,
    @required AnimationController controller,
    this.iconsHeightWidth,
  })  : _controller = controller,
        super(key: key);

  final double fullVideoViewPortHeight;
  final AnimationController _controller;
  final double iconsHeightWidth;

  @override
  _AllCommentsState createState() => _AllCommentsState();
}

class _AllCommentsState extends State<AllComments>
    with SingleTickerProviderStateMixin {
  final TextEditingController _commentsController = TextEditingController();

  final ScrollController _scrollController = new ScrollController();

  final FirebaseApi _firebaseApi = new FirebaseApi();

  AnimationController _replyController;

   FocusNode focusNodeReply ;
  FocusNode focusNodeComment ;

  @override
  void initState() {
    super.initState();
    focusNodeReply = FocusNode();
    focusNodeComment = FocusNode();
    _replyController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _replyController.dispose();
    focusNodeReply.dispose();
    focusNodeComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myScrollProvider =
        Provider.of<ScrollProvider>(context, listen: false);
    //Comments Section. Replace Content of Container according to your needs.
    return Container(
      color: Colors.white,
      height: widget.fullVideoViewPortHeight * 0.6 * widget._controller.value,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CommentTitleWithAvatar(
                      focusNodeReply: focusNodeReply,
                      firebaseApi: _firebaseApi,
                      replyAnimationController: _replyController,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //Replies
                    Padding(
                      //padding calculated by Avatar Diameter + total padding around avatar
                      //40 + 16
                      padding: EdgeInsets.only(left: 56),
                      child: Column(
                        children: [
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
                          ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return CommentTitleWithAvatar(
                                focusNodeReply: focusNodeReply,
                                firebaseApi: _firebaseApi,
                                replyAnimationController: _replyController,
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
          //Replying To Vrushank
          AnimatedBuilder(
              animation: _replyController,
              builder: (BuildContext context, Widget child) {
                return Column(
                  children: [
                    Offstage(
                      offstage: _replyController.value <= 0.01 ? true : false,
                      child: Align(
                        heightFactor: _replyController.value,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          // Add a comment
                          title: Text(
                            'Replying To Vrushank',
                            style: TextStyle(fontSize: 14),
                          ),
                          // Post Button
                          trailing: IconButton(
                            onPressed: () {
                              _replyController.reverse(from: 1);
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
                    Visibility(
                      visible:  _replyController.value <= 0.01 ? true : false,
                      child: ListTile(
                        dense: true,
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
                        title: TextField(
                          focusNode: focusNodeComment,
                          controller: _commentsController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 2,
                          minLines: 1,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: widget.iconsHeightWidth * 0.9,
                          ),
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.black,
                        ),
                        // Post Button
                        trailing: TextButton(
                          onPressed: () async {
                            await _firebaseApi.addComment(
                                userId: "Abhishak",
                                postId: "Post001",
                                comment: "Some Comment",
                                timestamp: Timestamp.now());
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff396BBC),
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //AddReply
                    Visibility(
                      visible:  _replyController.value <= 0.01 ? false : true,
                      child: ListTile(
                        dense: true,
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
                        title: TextField(
                          focusNode: focusNodeReply,
                          autofocus: true,
                          controller: _commentsController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 2,
                          minLines: 1,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: widget.iconsHeightWidth * 0.9,
                          ),
                          decoration: InputDecoration(
                            hintText: "Add a reply...",
                            hintStyle: TextStyle(
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.black,
                        ),
                        // Post Button
                        trailing: TextButton(
                          onPressed: () async {
                            // await _firebaseApi.addComment(
                            //     userId: "Abhishak",
                            //     postId: "Post001",
                            //     comment: "Some Comment",
                            //     timestamp: Timestamp.now());
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff396BBC),
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

        ],
      ),
    );
  }
}
