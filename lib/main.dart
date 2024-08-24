import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_c11/core/application_them_manager.dart';
import 'package:todo_app_c11/core/page_route_names.dart';
import 'package:todo_app_c11/core/route_generator.dart';
import 'package:todo_app_c11/services/loading_service.dart';

import 'firebase_options.dart';

bool darkMode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  ConfigLoading();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO DO LIST',
      theme: ApplicationThemeManager.lightThemeData,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
