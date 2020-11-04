import 'package:equatable/equatable.dart';
import 'package:structure_flutter/data/entities/account.dart';

abstract class LoadDataState extends Equatable {
  LoadDataState([List props = const []]) : super();
}

class LoadingData extends LoadDataState {
  final String message = "loading";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class Failure extends LoadDataState {
  final String message = "Failure!";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class Success extends LoadDataState {
  final List<Account> data;

  Success(this.data);

  @override
  List<Object> get props => [data];
}
