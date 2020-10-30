import 'package:flutter/material.dart';
import 'core/common/enums/environment.dart';
import 'main_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await mainCommon(JCEnvironment.DEV);
}
