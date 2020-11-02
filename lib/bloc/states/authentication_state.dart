import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();
}

class Uninitialized extends AuthenticationState {
  final String message = "Uninitialized";

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => '{ displayName: ${user.displayName} }';

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  final String message = "Unauthenticated";

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}
