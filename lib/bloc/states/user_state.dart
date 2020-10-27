// import 'package:equatable/equatable.dart';
// import 'package:structure_flutter/data/entities/user.dart';
//
// abstract class UserGitState extends Equatable {
//   UserGitState([List props = const []]) : super(props);
// }
//
// class UserGitUnInitialized extends UserGitState {
//   @override
//   String toString() => "UserGitUnInitialized";
// }
//
// class UserGitError extends UserGitState {
//   @override
//   String toString() => "UserGitError";
// }
//
// class UserGitLoaded extends UserGitState {
//   final List<UserGitEntity> users;
//   final bool hasReachMax;
//
//   UserGitLoaded({this.users, this.hasReachMax}) : super([users, hasReachMax]);
//
//   UserGitLoaded copyWith({
//     List<UserGitEntity> posts,
//     bool hasReachedMax,
//   }) {
//     return UserGitLoaded(
//       users: posts ?? this.users,
//       hasReachMax: hasReachedMax ?? this.hasReachMax,
//     );
//   }
//
//   @override
//   String toString() => "UserGitLoaded";
// }
