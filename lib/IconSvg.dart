
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class IconSvg extends StatelessWidget {
  final iconsHeightAndWidth;
  final svgString;
  IconSvg({@required this.iconsHeightAndWidth, @required this.svgString});
  @override
  Widget build(BuildContext context) {
    return WebsafeSvg.asset(
      svgString,
      width: iconsHeightAndWidth,
      height: iconsHeightAndWidth,
      color: Colors.grey,
    );
  }
}