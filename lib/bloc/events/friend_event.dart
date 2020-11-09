import 'package:equatable/equatable.dart';

abstract class FriendEvent extends Equatable {
  FriendEvent([List props = const []]) : super();
}

class InitializeLoadData extends FriendEvent {
  final String message = "InitializeLoadData";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}
