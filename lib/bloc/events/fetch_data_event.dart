import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FetchDataEvent extends Equatable {
  FetchDataEvent([List props = const []]) : super();
}

class FetchDataStarted extends FetchDataEvent {
  final String message = 'AppStarted';

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class FetchDataSuccess extends FetchDataEvent {
  final String message = 'AppStarted';

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}