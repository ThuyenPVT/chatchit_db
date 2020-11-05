import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/bloc/events/fetch_data_event.dart';
import 'package:structure_flutter/bloc/states/fetch_data_state.dart';
import '../bloc.dart';

@singleton
class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataBloc(FetchDataState initialState) : super(initialState);

  @override
  Stream<FetchDataState> mapEventToState(FetchDataEvent event) async* {
    if (event is FetchDataStarted) {
      yield* _mapFetchDataToState();
    } else if (event is FetchDataSuccess) {
      yield* _mapFetchDataToState();
    }
  }

  Stream<FetchDataState> _mapFetchDataToState() async* {
    AsyncSnapshot<QuerySnapshot> snapshot;

    yield FetchDataState.Waiting();
    try {
      yield FetchDataState.Data(snapshot);
    } catch (_) {
      yield FetchDataState.Error();
    }
  }
}
