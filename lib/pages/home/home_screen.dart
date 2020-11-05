import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/pages/friend_list/friend_list_screen.dart';
import 'package:structure_flutter/pages/setting/setting_screen.dart';

import '../../core/resource/icon_style.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _authenticationBloc = getIt<AuthenticationBloc>();

  User get user => widget.user;

  TabController _tabController;

  static final _tabBarItems = <Tab>[
    Tab(icon: AppIcons.chat_blue),
    Tab(icon: AppIcons.call_blue),
    Tab(icon: AppIcons.people_blue),
    Tab(icon: AppIcons.setting_blue),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabBarItems.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 0,
        color: AppColors.white,
        child: TabBar(
          tabs: _tabBarItems,
          controller: _tabController,
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authenticationBloc.add(LoggedOut());
            },
          ),
        ],
      ),
      body: _tabBarPages(),
    );
  }

  Widget _tabBarPages() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Text('Recent conversation screen !'),
        FriendListScreen(user),
        Text('Group friend screen!'),
        SettingScreen(user),
      ],
    );
  }
}
