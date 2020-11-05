import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [password];
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [email, password];
}

class LoginWithGoogle extends LoginEvent {
  final String message = "LoginWithGooglePressed";

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class LoginWithCredentials extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentials({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [email, password];
}
