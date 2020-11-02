import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super();
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({@required this.email}) : super([email]);

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({@required this.password}) : super([password]);

  @override
  List<Object> get props => [password];
}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;

  RegisterFullNameChanged({@required this.fullName}) : super([fullName]);

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
  final File imageURL;

  RegisterWithCredentials({
    @required this.fullName,
    @required this.email,
    @required this.password,
    this.imageURL,
  });

  @override
  List<Object> get props => [fullName, email, password, imageURL];
}
