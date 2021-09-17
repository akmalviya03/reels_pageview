import 'package:flutter/material.dart';

import 'AlertButton.dart';
class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    Key key,@required this.onTapDelete,
  }) : super(key: key);

  final VoidCallback onTapDelete;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: 8),
                child: Text(
                  "Are you sure want to delete?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 16),
                child: Text(
                  'This will delete your comment from this post',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                mainAxisSize:
                MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  AlertButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    buttonText: 'Close',
                    buttonColor:
                    Color(0xff396BBC),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(
                        left: 16),
                    child: AlertButton(
                      onTap: onTapDelete,
                      buttonText: 'Delete',
                      buttonColor:
                      Colors.red,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}