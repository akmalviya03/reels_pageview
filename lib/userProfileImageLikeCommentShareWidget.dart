import 'package:flutter/material.dart';
import 'package:reels_pageview/userProfileImageAndName.dart';
import 'likeCommentShareButtons.dart';
import 'likesAndCommentsOnVideo.dart';
class UserProfileImageLikeCommentShare extends StatelessWidget {
  const UserProfileImageLikeCommentShare({
    Key key,
    @required this.iconsHeightAndWidth,
    @required AnimationController controller,
  }) : _controller = controller, super(key: key);

  final double iconsHeightAndWidth;
  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.all(iconsHeightAndWidth * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          UserProfileImageAndName(
              profileHeightAndWidth:
              iconsHeightAndWidth),
          SizedBox(
            height: iconsHeightAndWidth * 0.3,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              LikeCommentShareButtons(
                  iconSize: iconsHeightAndWidth * 0.5,
                  controller: _controller),
              LikesAndCommentsOnVideo(
                  iconSize: iconsHeightAndWidth * 0.5)
            ],
          ),
        ],
      ),
    );
  }
}