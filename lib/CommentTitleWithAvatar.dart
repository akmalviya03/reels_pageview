import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CommentTitleWithAvatar extends StatelessWidget {
  const CommentTitleWithAvatar({
    Key key,
    @required this.userName,
    @required this.userAvatar,
    @required this.commentOrReplyText,@required this.onTap,@required this.onLongPress,
  }) : super(key: key);

  final String commentOrReplyText;
  final String userAvatar;
  final String userName;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      dense: true,
      horizontalTitleGap: 8,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      //UserImage
      leading: CircleAvatar(
        foregroundImage: NetworkImage(
            userAvatar),
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
              userName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            ReadMoreText(
              commentOrReplyText,
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
                  onTap: onTap,
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
