import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/pages/friend_list/widgets/avatar.dart';

import 'followers.dart';

class FriendProfile extends StatefulWidget {
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
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile>
    with TickerProviderStateMixin {
  final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
  AnimationController _animationController;

  double _containerPaddingLeft = 20.0;
  double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;

  bool show;
  bool sent = false;
  Color _color = AppColors.lightGreen;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.green;
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Stack(
          children: [
            Column(
              children: [
                Avatar(widget.image, widget.colors),
                SizedBox(height: 5),
                Text(widget.name, style: AppStyles.black_14),
                SizedBox(height: 10),
                Followers(widget.feed, widget.followers),
                SizedBox(height: 20),
                Container(
                    child: GestureDetector(
                        onTap: () {
                          _animationController.forward();
                          widget.onPressed();
                        },
                        child: AnimatedContainer(
                            decoration: BoxDecoration(
                              color: _color,
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                BoxShadow(
                                  color: _color,
                                  blurRadius: 21, // soften the shadow
                                  spreadRadius: -15, //end the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    20.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(
                                left: _containerPaddingLeft,
                                right: 10.0,
                                top: 5.0,
                                bottom: 3.0),
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                (!sent)
                                    ? AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        child: Icon(
                                          Icons.send,
                                          color: AppColors.white,
                                        ),
                                        curve: Curves.fastOutSlowIn,
                                        transform: Matrix4.translationValues(
                                            _translateX, _translateY, 0)
                                          ..rotateZ(_rotate)
                                          ..scale(_scale),
                                      )
                                    : Container(),
                                AnimatedSize(
                                  vsync: this,
                                  duration: Duration(milliseconds: 600),
                                  child: show
                                      ? SizedBox(width: 10.0)
                                      : Container(),
                                ),
                                AnimatedSize(
                                  vsync: this,
                                  duration: Duration(milliseconds: 200),
                                  child: show
                                      ? Text(
                                          "Send",
                                          style: AppStyles.white,
                                        )
                                      : Container(),
                                ),
                                AnimatedSize(
                                  vsync: this,
                                  duration: Duration(milliseconds: 200),
                                  child: sent
                                      ? Icon(
                                          Icons.done,
                                          color: AppColors.white,
                                        )
                                      : Container(),
                                ),
                                AnimatedSize(
                                  vsync: this,
                                  alignment: Alignment.topLeft,
                                  duration: Duration(milliseconds: 600),
                                  child: sent
                                      ? SizedBox(width: 10.0)
                                      : Container(),
                                ),
                                AnimatedSize(
                                  vsync: this,
                                  duration: Duration(milliseconds: 200),
                                  child: sent
                                      ? Center(
                                          child: Text(
                                            "Done",
                                            style: AppStyles.white,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            )))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
