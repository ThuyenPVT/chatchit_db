import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/widgets/loading_widget.dart';

class ConversationPage extends StatefulWidget {
  final String conversationID;
  final String recipientID;
  final String receiverName;
  final String receiverImage;

  ConversationPage(
    this.conversationID,
    this.recipientID,
    this.receiverName,
    this.receiverImage,
  );

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  ScrollController _listViewController = ScrollController();

  final _accountRepository = getIt<AccountRepository>();

  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_249_246_247,
      appBar: AppBar(
        leading: IconButton(
          icon: AppIcons.arrowBack_white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: AppColors.blueNormal,
        title: Text(widget.receiverName, style: AppStyles.white),
      ),
      body: _conversationUI(),
    );
  }

  Widget _conversationUI() {
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(includeMetadataChanges: true),
        builder:
            (BuildContext _context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text('Something went wrong !'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.hasData) {
            var conversationData = snapshot.data;
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    height: 0.5,
                    color: AppColors.black54,
                  ),
                ],
              ),
            );
          }
          return Loading();
        });
  }
}
