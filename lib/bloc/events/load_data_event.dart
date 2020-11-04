import 'package:equatable/equatable.dart';

abstract class LoadDataEvent extends Equatable {
  LoadDataEvent([List props = const []]) : super();
}

class InitializeLoadData extends LoadDataEvent {
  final String message = "InitializeLoadData";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}
