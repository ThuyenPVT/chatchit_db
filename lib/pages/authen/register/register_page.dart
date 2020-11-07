import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/pages/authen/register/widgets/register_widget.dart';

import 'widgets/app_bar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RegisterPage> {
  final _registerBloc = getIt<RegisterBloc>();

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: appBar(context),
      body: BlocProvider<RegisterBloc>(
        create: (context) => _registerBloc,
        child: RegisterWidget(),
      ),
    );
  }
}
