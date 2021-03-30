import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:reels_pageview/userProfileImageLikeCommentShare.dart';
import 'package:reels_pageview/videoPlayerWithControls.dart';
import 'allComments.dart';

class VideoAnimationTile extends StatefulWidget {
  final String url;
  final bool play;
  VideoAnimationTile(
      {@required this.url,@required this.play});
  @override
  _VideoAnimationTileState createState() => _VideoAnimationTileState();
}

class _VideoAnimationTileState extends State<VideoAnimationTile>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
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
    if(widget.play){
      _betterPlayerController.setLooping(true);
      _betterPlayerController.play();
    }else{
      _betterPlayerController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Calculating working Area.
    double fullVideoViewPortHeight = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        ScreenUtil().statusBarHeight;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: fullVideoViewPortHeight,
      color: Colors.black,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {

              //Calculating icons Height And Width For Responsiveness.
              iconsHeightAndWidth = (fullVideoViewPortHeight * 1) * 0.05 -
                  (((fullVideoViewPortHeight * 1) * 0.05) / 2) *
                      _controller.value;

              return Column(
                children: [
                  //Video Section
                  FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      //Both Height and width are Responsible for viewport height and width change.
                      height: fullVideoViewPortHeight -
                          fullVideoViewPortHeight * 0.6 * _controller.value,
                      width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.6*_controller.value,
                      child: AspectRatio(
                        aspectRatio: 9/16,
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
                            )
                      ),
                    ),
                  ),

                  //All Comments
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AllComments(
                        fullVideoViewPortHeight: fullVideoViewPortHeight,
                        controller: _controller),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
