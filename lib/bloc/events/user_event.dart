import 'package:equatable/equatable.dart';

abstract class UserGitEvent extends Equatable {}

class Fetch extends UserGitEvent {
  @override
  String toString() => "fetch";
}
