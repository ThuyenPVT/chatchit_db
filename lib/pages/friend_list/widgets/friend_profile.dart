import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/pages/friend_list/widgets/avatar.dart';

import 'followers.dart';

class FriendProfile extends StatelessWidget {
  String name;
  String image;
  bool colors;
  int followers;
  int feed;
  VoidCallback onPressed;
  bool isActiveButton;

  FriendProfile({
    this.name,
    this.image,
    this.followers,
    this.colors,
    this.feed,
    this.onPressed,
    this.isActiveButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Stack(
          children: [
            Column(
              children: [
                Avatar(image, colors),
                SizedBox(height: 5),
                Text(name, style: AppStyles.black_14),
                SizedBox(height: 10),
                Followers(feed, followers),
                SizedBox(height: 20),
                Container(
                  height: 30,
                  width: 100,
                  child: FlatButton(
                    color:
                        isActiveButton ? AppColors.lightGreen : AppColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: onPressed,
                    child: isActiveButton
                        ? Text('Send Request', style: AppStyles.white_10)
                        : Text('Pending', style: AppStyles.white_10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
