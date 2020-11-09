import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class AddFriendButton extends StatelessWidget {
  final VoidCallback sendRequest;

  AddFriendButton({Key key, VoidCallback sendRequest})
      : sendRequest = sendRequest,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      child: FlatButton(
        color: Colors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: sendRequest,
        child: Text(
          'Send Request',
          style: AppStyles.white_10,
        ),
      ),
    );
  }
}
