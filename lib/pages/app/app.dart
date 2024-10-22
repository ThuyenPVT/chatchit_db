import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/pages/authen/login/login_screen.dart';
import 'package:structure_flutter/pages/home/home_screen.dart';
import 'package:structure_flutter/pages/splash/splash_screen.dart';

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _authenticationBloc = getIt<AuthenticationBloc>();
  final _loginBloc = getIt<LoginBloc>();

  @override
  void initState() {
    super.initState();
    _authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder(
          cubit: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen();
            }
            if (state is Authenticated) {
              return HomeScreen(user: state.user);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
