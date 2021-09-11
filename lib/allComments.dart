import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/scrollProvider.dart';

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

  @override
  Widget build(BuildContext context) {
    final myScrollProvider =
        Provider.of<ScrollProvider>(context, listen: false);
    //Comments Section. Replace Content of Container according to your needs.
    return SizedBox(
      height: fullVideoViewPortHeight * 0.6 * _controller.value,
      width: MediaQuery.of(context).size.width,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Comments',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  _controller.reverse(from: 1);
                  FocusScope.of(context).requestFocus(FocusNode());
                  myScrollProvider.updateScrollable(scrollValue: true);
                },
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.close,
                ),
                color: Colors.black,
                tooltip: 'Close',
              ),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    children: [
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
                        title: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vrushank Shah',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Vrushank Shah',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
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
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Post Button
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        //padding calculated by Avatar Diameter + total padding around avatar
                        //40 + 16 + 8
                        padding: EdgeInsets.only(left: 64),
                        child: Column(
                          children: [
                            Row(
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
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Show previous replies',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            ListView(
                              controller: _scrollController,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.only(
                                      right: 8, top: 2, bottom: 2,),
                                  //UserImage
                                  leading: CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80'),
                                  ),
                                  // Add a comment
                                  title: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Vrushank Shah',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Vrushank Shah',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Post Button
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Add a Comment Text field & Post Button
              Container(
                color: Colors.white,
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
                    onChanged: (text) {
                      if (text.trim().isEmpty) {
                      } else {}
                    },
                  ),
                  // Post Button
                  trailing: Text(
                    "Post",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
