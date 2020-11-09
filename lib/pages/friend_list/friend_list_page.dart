import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/common/helpers/random_helper.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/widgets/loading_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';
import 'widgets/friend_profile.dart';

class FriendListPage extends StatefulWidget {
  String currentUid;

  FriendListPage(this.currentUid);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<FriendListPage> {
  final _accountRepository = getIt<AccountRepository>();

  final _snackBar = getIt<SnackBarWidget>();

  final _loadDataBloc = getIt<LoadDataBloc>();

  final _random = getIt<RandomHelper>();

  @override
  void dispose() {
    _loadDataBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _loadDataBloc.add(InitializeLoadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _loadDataBloc,
      listener: (BuildContext context, LoadDataState state) {
        _snackBar.buildContext = context;
        if (state is Loading) {
          Loading();
        }
        if (state is Failure) {
          _snackBar.failure("Something went wrong !");
        }
        if (state is Success) {
          _snackBar.success("Looking for friends near you !");
        }
      },
      child: _onRenderGridFriend(),
    );
  }

  Widget _onRenderGridFriend() {
    return BlocBuilder(
      cubit: _loadDataBloc,
      builder: (BuildContext context, LoadDataState state) {
        if (state is Loading) {
          return Loading();
        }
        if (state is Failure) {
          _snackBar.failure("Something went wrong !");
        }
        if (state is Success) {
          return Column(
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
                  children: state.data.map((Account account) {
                    return _buildGridView(account);
                  }).toList(),
                ),
              ),
            ],
          );
        }
        return Loading();
      },
    );
  }

  Widget _buildGridView(Account recipient) {
    return FriendProfile(
      name: recipient.name,
      image: recipient.image,
      followers: _random.followers(),
      colors: _random.colors(),
      feed: _random.feed(),
      onPressed: () => _onPressed(recipient.id, recipient.name),
      isActiveButton: true,
    );
  }

  void _onPressed(String recipientID, String name) {
    _accountRepository.sendFriendRequest(
      currentID: widget.currentUid,
      recipientID: recipientID,
      name: name,
      pending: true,
    );
  }
}
