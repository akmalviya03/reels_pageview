import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_pageview/scrollProvider.dart';

class AllComments extends StatelessWidget {
   AllComments({
    Key key,
    @required this.fullVideoViewPortHeight,
    @required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final double fullVideoViewPortHeight;
  final AnimationController _controller;
final ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final myScrollProvider =
        Provider.of<ScrollProvider>(context, listen: false);
    //Comments Section. Replace Content of Container according to your needs.
    return Container(
      height: fullVideoViewPortHeight * 0.6 * _controller.value,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Align(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 10,
                addAutomaticKeepAlives: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item ${index + 1}'),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.reverse(from: 1);
              myScrollProvider.updateScrollable(scrollValue: true);
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
