import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/replyProvider.dart';
import 'package:reels_pageview/scrollProvider.dart';
import 'package:reels_pageview/videoAnimationTile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
        ChangeNotifierProvider(create: (_) => ReplyProvider()),
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
  Random random = new Random();
  int currentIndex = 0;
  final List<String> urls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  ];

  final List<String> postId = ["PID001", "PID002", "PID003", "PID004"];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      allowFontScaling: false,
      builder: () => MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: Consumer<ScrollProvider>(
              builder: (context, myScrollProvider, child) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: urls.length,
                  pageSnapping: true,
                  physics: myScrollProvider.scrollable
                      ? PageScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Align(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: VideoAnimationTile(
                          url: urls[index],
                          postId: postId[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'School',
                ),
              ],
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
