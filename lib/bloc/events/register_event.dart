import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super();
}

class EmailChange extends RegisterEvent {
  final String email;

  EmailChange({@required this.email}) : super([email]);

  @override
  List<Object> get props => [email];
}

class PasswordChange extends RegisterEvent {
  final String password;

  PasswordChange({@required this.password}) : super([password]);

  @override
  List<Object> get props => [password];
}

class FullNameChange extends RegisterEvent {
  final String fullName;

  FullNameChange({@required this.fullName}) : super([fullName]);

  @override
  List<Object> get props => [fullName];
}

class Submit extends RegisterEvent {
  final String email;
  final String password;

  Submit({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  List<Object> get props => [email, password];
}

class RegisterWithCredentials extends RegisterEvent {
  final String fullName;
  final String email;
  final String password;
  final String imageURL;

  RegisterWithCredentials({
    @required this.fullName,
    @required this.email,
    @required this.password,
    this.imageURL,
  });

  @override
  List<Object> get props => [fullName, email, password, imageURL];
}
