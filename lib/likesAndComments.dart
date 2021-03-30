import 'package:flutter/material.dart';

import 'IconSvg.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({
    Key key,
    @required this.iconSize,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconSvg(
              iconsHeightAndWidth: iconSize*0.7,
              svgString: 'assets/svgs/like.svg',
            ),
            Text(
              ' 230k',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400, fontSize: iconSize*0.7),
            ),
          ],
        ),
        SizedBox(width: iconSize * 0.7,),
        Row(
          children: [
            IconSvg(
              iconsHeightAndWidth: iconSize*0.7,
              svgString: 'assets/svgs/comment.svg',
            ),
            Text(
              ' 145k',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400, fontSize: iconSize*0.7),
            ),
          ],
        ),
      ],
    );
  }
}