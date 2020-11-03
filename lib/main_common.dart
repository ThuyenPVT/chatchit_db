import 'package:firebase_core/firebase_core.dart';

import 'di/injection.dart';
import 'package:flutter/material.dart';
import 'core/common/enums/environment.dart';
import 'package:structure_flutter/buildconfig/build_config.dart';
import 'package:structure_flutter/pages/application/application.dart';

Future<void> mainCommon(JCEnvironment environment) async {
  await BuildConfig.init(environment);
  await configureDependencies();
  runApp(Application());
}
