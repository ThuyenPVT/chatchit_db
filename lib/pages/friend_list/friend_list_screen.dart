import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/pages/friend_list/widgets/avatar.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/widgets/loading_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

import 'widgets/followers.dart';

class FriendListScreen extends StatefulWidget {
  User user;

  FriendListScreen(this.user);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<FriendListScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final _accountRepository = getIt<AccountRepository>();

  final _snackBar = getIt<SnackBarWidget>();

  User get user => widget.user;

  @override
  Widget build(BuildContext context) {
    //Validation data exist or not !
  }

  String convertTimeStampToHour(Map<String, dynamic> data) {
    int timestamp = data['lastSeen'].seconds;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat.jm().format(date);
  }

  Widget _buildGridView(DocumentSnapshot document) {
    String name = document.data()['name'].toString();
    String image = document.data()['image'].toString();
    String recipientID = document.data()['id'].toString();
    Random random = Random();
    bool randomColors = random.nextBool();
    int randomFollowers = random.nextInt(1500);
    int randomFeed = random.nextInt(100);
    return Container(
      child: Card(
        elevation: 10,
        child: Stack(
          children: [
            Column(
              children: [
                Avatar(image, randomColors),
                SizedBox(
                  height: 5,
                ),
                Text(name, style: AppStyles.black_14),
                SizedBox(height: 10),
                Followers(randomFeed, randomFollowers),
                SizedBox(height: 20),
                Container(
                  height: 30,
                  width: 100,
                  child: FlatButton(
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      _accountRepository.sendFriendRequest(
                          user.uid, recipientID, name, true);
                    },
                    child: Text(
                      'Send Request',
                      style: AppStyles.white_10,
                    ),
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
