import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/core/utils/date_time_utils.dart';
import 'package:structure_flutter/data/entities/conversation.dart';
import 'package:structure_flutter/data/entities/message.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/widgets/loading_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  final _snackBar = getIt<SnackBarWidget>();

  final _friendBloc = getIt<FriendBloc>();

  final _conversationBloc = getIt<ConversationBloc>();

  final _dateTimeUtils = getIt<DateTimeUtils>();

  @override
  void dispose() {
    _listViewController.dispose();
    _friendBloc.close();
    _conversationBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _conversationBloc.add(InitConversation());
    super.initState();
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
        backgroundColor: AppColors.outer_space,
        title: Text(widget.receiverName, style: AppStyles.white),
      ),
      body: _conversationUI(),
    );
  }

  Widget _conversationUI() {
    return BlocListener(
      cubit: _conversationBloc,
      listener: (BuildContext context, ConversationState state) {
        _snackBar.buildContext = context;
        if (state is LoadingConversation) {
          return Loading();
        }
        if (state is FailureConversation) {
          _snackBar.failure("Something went wrong!");
        }
        if (state is SuccessConversation) {}
      },
      child: BlocBuilder(
        cubit: _conversationBloc,
        builder: (BuildContext context, ConversationState state) {
          if (state is LoadingConversation) {
            Loading();
          }
          if (state is SuccessConversation) {
            return _conversationPageUI(context, state.conversation);
          }
          if (state is FailureConversation) {
            Loading();
          }
          return Loading();
        },
      ),
    );
  }

  Widget _conversationPageUI(
    BuildContext _context,
    List<Conversation> conversations,
  ) {
    return _buildList(conversations);
  }

  Widget _buildList(List<Conversation> conversation) {
    if (conversation != null) {
      conversation.map((Conversation conversation) {
        if (conversation != null) {
          if (conversation.messages.length != 0) {
            return ListView.builder(
                controller: _listViewController,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemCount: conversation.messages.length,
                itemBuilder: (BuildContext _context, int _index) {
                  var _message = conversation.messages[_index];
                  bool _isOwnMessage = _message.senderID == widget.recipientID;
                  return _messageListViewChild(_isOwnMessage, _message);
                });
          } else {
            return Align(
              alignment: Alignment.center,
              child: Text("Let's start a conversation!"),
            );
          }
        } else {
          return SpinKitWanderingCubes(
            color: Colors.blue,
            size: 50.0,
          );
        }
      }).toList();
    }
  }

  Widget _messageListViewChild(bool _isOwnMessage, Message _message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            _isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          !_isOwnMessage ? _userImageWidget() : Container(),
          SizedBox(width: 50),
          _message.type == MessageType.Text
              ? _textMessageBubble(
                  _isOwnMessage, _message.content, _message.timestamp)
              : _imageMessageBubble(
                  _isOwnMessage, _message.content, _message.timestamp),
        ],
      ),
    );
  }

  Widget _imageMessageBubble(
      bool _isOwnMessage, String _imageURL, Timestamp _timestamp) {
    List<Color> _colorScheme = _isOwnMessage
        ? [Colors.blue, Color.fromRGBO(42, 117, 188, 1)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    DecorationImage _image =
        DecorationImage(image: NetworkImage(_imageURL), fit: BoxFit.cover);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: _colorScheme,
          stops: [0.30, 0.70],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: _image,
            ),
          ),
          Text(
            timeago.format(_timestamp.toDate()),
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _userImageWidget() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.receiverName),
        ),
      ),
    );
  }

  Widget _textMessageBubble(
      bool _isOwnMessage, String _message, Timestamp _timestamp) {
    List<Color> _colorScheme = _isOwnMessage
        ? [Colors.blue, Color.fromRGBO(42, 117, 188, 1)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    return Container(
      height: 200,
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: _colorScheme,
          stops: [0.30, 0.70],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(_message),
          Text(
            timeago.format(_timestamp.toDate()),
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
