import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FetchDataState extends Equatable {
  FetchDataState([List props = const []]) : super();
}

class Error extends FetchDataState {
  final String message = "Has error";

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class Success extends FetchDataState {
  final AsyncSnapshot<QuerySnapshot> snapshot;

  Success(this.snapshot) : super([snapshot]);

  @override
  List<Object> get props => [snapshot];
}

class Waiting extends FetchDataState {
  final String message = "Waiting ...";

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}
