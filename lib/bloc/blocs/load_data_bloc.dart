import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/events/load_data_event.dart';
import 'package:structure_flutter/bloc/states/load_data_state.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/account_repository.dart';

class LoadDataBloc extends Bloc<LoadDataEvent, LoadDataState> {
  LoadDataBloc(LoadDataState initialState) : super(initialState);
  final _accountRepository = getIt<AccountRepository>();

  @override
  Stream<LoadDataState> mapEventToState(LoadDataEvent event) async* {
    if (event is InitializeLoadData) {
      yield* _mapLoadDataToState();
    }
  }

  Stream<LoadDataState> _mapLoadDataToState() async* {
    yield LoadingData();
    try {
      final _currentId = FirebaseAuth.instance.currentUser;
      print(_currentId.uid.toString());
      final _data = await _accountRepository.parseToObject(_currentId.uid);
      yield Success(_data);
    } catch (_) {
      yield Failure();
    }
  }
}
