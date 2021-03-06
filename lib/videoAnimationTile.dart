import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reels_pageview/userProfileImageLikeCommentShareWidget.dart';
import 'package:reels_pageview/videoPlayerWithControls.dart';
import 'allComments.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoAnimationTile extends StatefulWidget {
  final String url;
  final String postId;
  VideoAnimationTile({@required this.url, @required this.postId});
  @override
  _VideoAnimationTileState createState() => _VideoAnimationTileState();
}

class _VideoAnimationTileState extends State<VideoAnimationTile>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  BetterPlayerController _betterPlayerController;
  AnimationController _controller;
  double iconsHeightAndWidth;
  bool mute = true;

  @override
  void initState() {
    super.initState();
    /*Animation Controller To Control Video ViewPort Size*/
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      fit: BoxFit.fill,
      aspectRatio: (9 / 16),
      //Turned visibility off of icons by setting value to false.
      controlsConfiguration:
          BetterPlayerControlsConfiguration(showControls: false),
    );

    //  Setting Up Data Source
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          //We Had To Change these Settings.
          maxCacheSize: 2 * 1024 * 1024 * 1024,
          maxCacheFileSize: 50 * 1024 * 1024),
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Calculating working Area.
    double fullVideoViewPortHeight = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        ScreenUtil().statusBarHeight;

    //This is
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (visibilityInfo) {
        if ((visibilityInfo.visibleFraction * 100) > 70) {
          _betterPlayerController.play();
        } else {
          _betterPlayerController.pause();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: fullVideoViewPortHeight,
        color: Colors.black,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, Widget child) {
            //Calculating icons Height And Width For Responsiveness.
            iconsHeightAndWidth = (fullVideoViewPortHeight * 1) * 0.05 -
                (((fullVideoViewPortHeight * 1) * 0.05) / 2) *
                    _controller.value;

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //Video Section
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      //Both Height and width are Responsible for viewport height and width change.
                      height: fullVideoViewPortHeight -
                          fullVideoViewPortHeight * 0.6 * _controller.value,
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width *
                              0.6 *
                              _controller.value,
                      child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              /*Volume 1 equal to 100% */
                              VideoPlayerWithControls(
                                  betterPlayerController:
                                      _betterPlayerController),
                              UserProfileImageLikeCommentShare(
                                  iconsHeightAndWidth: iconsHeightAndWidth,
                                  controller: _controller),
                            ],
                          )),
                    ),
                  ),
                ),

                //All Comments
                AllComments(
                  fullVideoViewPortHeight: fullVideoViewPortHeight,
                  controller: _controller,
                  postId: widget.postId,
                  userId: "UID001",
                  userAvatar: 'https://images.unsplash.com/photo-1585675100414-add2e465a136?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                  userName: 'Vrushank Shah',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
