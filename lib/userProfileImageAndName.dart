import 'package:flutter/material.dart';

class UserProfileImageAndName extends StatelessWidget {
  const UserProfileImageAndName({
    Key key,
    @required this.profileHeightAndWidth,
  }) : super(key: key);

  final double profileHeightAndWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //User Profile Image
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: profileHeightAndWidth*0.8,
            height: profileHeightAndWidth*0.8,
            child: Image.network(
              'https://i.pinimg.com/originals/d4/73/76/d473761560fc502029d30a466704e07c.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),

        //UserName
        Padding(
          padding: EdgeInsets.fromLTRB(profileHeightAndWidth * 0.2, 0, 0, 0),
          child: Text(
            'john_doe',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: profileHeightAndWidth*0.35),
          ),
        )
      ],
    );
  }
}
