import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/common/enums/environment.dart';
import 'main_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await mainCommon(JCEnvironment.DEV);
}
