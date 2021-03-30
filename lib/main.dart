import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/scrollProvider.dart';
import 'package:reels_pageview/videoAnimationTile.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List colors = [Colors.red, Colors.green, Colors.yellow];

  Random random = new Random();

  int currentIndex=0;

  final List<String> urls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        allowFontScaling: false,
        builder: () => MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: PageView.builder(
            scrollDirection: Axis.vertical,
              itemCount: urls.length,
              onPageChanged: (page) {
                print('Mypage $page');
                print(currentIndex);
              },
              itemBuilder: (context, index) {
                currentIndex = index;
                return Align(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: colors[random.nextInt(3)],
                    child: VideoAnimationTile(
                      play: currentIndex == index,
                      url: urls[index],
                    ),
                  ),
                );
              }),
        ),
      ),
    ));
  }
}
