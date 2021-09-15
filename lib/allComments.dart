import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:reels_pageview/scrollProvider.dart';
import 'FireBaseAPI.dart';

class AllComments extends StatelessWidget {
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
  final TextEditingController _commentsController = TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  final FirebaseApi _firebaseApi = new FirebaseApi();
  @override
  Widget build(BuildContext context) {
    final myScrollProvider =
        Provider.of<ScrollProvider>(context, listen: false);
    //Comments Section. Replace Content of Container according to your needs.
    return Container(
      color: Colors.white,
      height: fullVideoViewPortHeight * 0.6 * _controller.value,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ListTile(
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
                _controller.reverse(from: 1);
                myScrollProvider.updateScrollable(scrollValue: true);
              },
              padding: EdgeInsets.all(0),
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
                    CommentTitleWithAvatar(),
                    SizedBox(
                      height: 4,
                    ),
                    //Replies
                    Padding(
                      //padding calculated by Avatar Diameter + total padding around avatar
                      //40 + 8
                      padding: EdgeInsets.only(left: 48),
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
                              return CommentTitleWithAvatar();
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
          // Add a Comment Text field & Post Button
          ListTile(
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
              controller: _commentsController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              minLines: 1,
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: iconsHeightWidth * 0.9,
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
                    comment: "Some Comment");
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
        ],
      ),
    );
  }
}

class CommentTitleWithAvatar extends StatelessWidget {
  const CommentTitleWithAvatar({
    Key key,
  }) : super(key: key);

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
                  onTap: () {},
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
