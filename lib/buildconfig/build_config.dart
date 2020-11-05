import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

import '../core/common/enums/environment.dart';

@singleton
class BuildConfig {
  static init(JCEnvironment environment) async {
    await Firebase.initializeApp();
  }
}
