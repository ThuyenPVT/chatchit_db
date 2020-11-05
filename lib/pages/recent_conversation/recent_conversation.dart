import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/widgets/loading_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

class RecentConversationScreen extends StatefulWidget {
  String currentUid;

  RecentConversationScreen(this.currentUid);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<RecentConversationScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final _snackBar = getIt<SnackBarWidget>();

  final _loadDataBloc = getIt<LoadDataBloc>();

  final _accountRepository = getIt<AccountRepository>();

  String get currentUid => widget.currentUid;

  @override
  void dispose() {
    _loadDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _loadDataBloc,
      listener: (BuildContext context, LoadDataState state) {
        _snackBar.buildContext = context;
        if (state is Loading) {
          return Loading();
        }
        if (state is Failure) {
          _snackBar.failure("Something went wrong!");
        }
        if (state is Success) {}
      },
      child: BlocBuilder(
        cubit: _loadDataBloc,
        builder: (BuildContext context, LoadDataState state) {
          if (state is Loading) {
            Loading();
          }
          if (state is Success) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.data.map((Account account) {
                        return _buildRow(account);
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    height: 0.5,
                    color: AppColors.black54,
                  ),
                  Expanded(
                    child: ListView(
                      children: state.data.map((Account document) {
                        return _buildList(document);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is Failure) {
            Loading();
          }
          return Loading();
        },
      ),
    );
  }

  Widget _buildRow(Account account) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(
          '${account.image}',
        ),
      ),
    );
  }

  Widget _buildList(Account account) {
    return ListTile(
      onTap: () {
        _accountRepository.createLastConversation(currentUid, account.id,
            account.id, account.image, "Hello world!", account.name, 4);
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.red,
        backgroundImage: NetworkImage('${account.image}'),
      ),
      title: Text(account.name),
      subtitle: Text('You sent a sticker'),
      trailing: Text('${account.getHours()}'),
    );
  }
}
