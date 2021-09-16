import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/replyProvider.dart';
class AddReplyOrCommentAvatarTextFiledPostButton extends StatelessWidget {
  const AddReplyOrCommentAvatarTextFiledPostButton({
    Key key,
    @required this.focusNode,
    @required TextEditingController textEditingController,
    @required this.userAvatar,
    @required this.hintText,
    @required this.onTap,@required this.visible,
  })  :
        _textEditingController = textEditingController,
        super(key: key);

  final FocusNode focusNode;
  final TextEditingController _textEditingController;
  final String userAvatar;
  final String hintText;
  final VoidCallback onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final myReplyProvider = Provider.of<ReplyProvider>(context, listen: false);
    return Visibility(
      visible: visible,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        //UserImage
        leading: CircleAvatar(
          foregroundImage: NetworkImage(userAvatar),
        ),
        // Add a comment
        title: TextField(
          focusNode: focusNode,
          autofocus: myReplyProvider.getAutoFocus(),
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 2,
          minLines: 1,
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
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
          onPressed: onTap,
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
    );
  }
}