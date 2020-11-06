import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class UserInformationScreen extends StatefulWidget {
  final String image;
  final String name;
  final String email;

  UserInformationScreen(this.image, this.name, this.email);

  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       children: [
      //         CircleAvatar(
      //           radius: 30,
      //           child: CircleAvatar(
      //             radius: 29,
      //             backgroundImage: NetworkImage(widget.image),
      //           ),
      //         ),
      //         SizedBox(
      //           width: 20,
      //         ),
      //         Column(
      //           children: [
      //             Text(
      //               widget.name,
      //               style: AppStyles.black_24,
      //             ),
      //             Text(
      //               widget.name,
      //               style: AppStyles.black12_10,
      //             ),
      //           ],
      //         ),
      //         Container(
      //           width: 200,
      //           alignment: Alignment.centerRight,
      //           child: Expanded(
      //             child: Icon(Icons.list),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Row(
      //       children: [
      //         Column(
      //           children: [
      //             Text('Feed'),
      //             Text('18'),
      //           ],
      //         )
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
