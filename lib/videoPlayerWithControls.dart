import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
class VideoPlayerWithControls extends StatefulWidget {
  const VideoPlayerWithControls({
    Key key,
    @required BetterPlayerController betterPlayerController,
  }) : _betterPlayerController = betterPlayerController, super(key: key);

  final BetterPlayerController _betterPlayerController;

  @override
  _VideoPlayerWithControlsState createState() => _VideoPlayerWithControlsState();
}

class _VideoPlayerWithControlsState extends State<VideoPlayerWithControls> {
  bool mute = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BetterPlayer(
          controller: widget._betterPlayerController),
      onTap: () {
        if (mute == true) {
          widget._betterPlayerController.setVolume(1);
          mute = false;
        } else {
          widget._betterPlayerController.setVolume(0);
          mute = true;
        }
      },
      onDoubleTap: () {
        if (widget._betterPlayerController.isPlaying()) {
          widget._betterPlayerController.pause();
        } else {
          widget._betterPlayerController.play();
        }
      },
    );
  }
}