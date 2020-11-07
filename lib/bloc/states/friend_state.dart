import 'package:equatable/equatable.dart';
import 'package:structure_flutter/data/entities/account.dart';

abstract class FriendState extends Equatable {
  FriendState([List props = const []]) : super();
}

class LoadingData extends FriendState {
  final String message = "loading";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class Failure extends FriendState {
  final String message = "Failure!";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class Success extends FriendState {
  final List<Account> data;

  Success(this.data);

  @override
  List<Object> get props => [data];
}
