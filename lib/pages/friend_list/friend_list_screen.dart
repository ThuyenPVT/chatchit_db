import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:structure_flutter/core/common/helpers/random_helper.dart';
import 'package:structure_flutter/core/resource/assets_images.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

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
  final _helper = getIt<RandomHelper>();

  User get user => widget.user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(includeMetadataChanges: true),
        builder: (
          BuildContext _context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          _snackBar.buildContext = _context;
          if (snapshot.hasError) {
            _snackBar.failure("Something went wrong !");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loading();
          }
          if (snapshot.hasData) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      crossAxisCount: 2,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return _buildGridView(document);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return _loading();
        });
  }

  String convertTimeStampToHour(Map<String, dynamic> data) {
    int timestamp = data['lastSeen'].seconds;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat.jm().format(date);
  }

  Widget _buildGridView(DocumentSnapshot document) {
    String name = document.data()['name'].toString();
    String avatar = document.data()['image'].toString();
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Baseline(
                    baseline: 35,
                    baselineType: TextBaseline.ideographic,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: randomColors ? Colors.red : Colors.blue,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: avatar != "null"
                            ? NetworkImage(avatar)
                            : NetworkImage(AssetsImage.avatarDefault),
                      ),
                    ),
                  ),
                ),
                Text(
                  name,
                  style: AppStyles.black_14,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Feed',
                          style: AppStyles.black14_10,
                        ),
                        Text('$randomFeed'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Followers',
                          style: AppStyles.black14_10,
                        ),
                        Text('$randomFollowers', style: AppStyles.black_16),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 30,
                  width: 100,
                  child: FlatButton(
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      _accountRepository.sendFriendRequest(user.uid, recipientID, name, true);
                      _accountRepository.sendFriendRequest(recipientID, user.uid, name, true);
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

  Widget _loading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading ...',
            style: AppStyles.black38_16,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
