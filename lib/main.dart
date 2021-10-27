import 'package:flutter/material.dart';
import 'package:website/routing/app_router.dart';
import 'package:website/routing/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Routes.app,
      onGenerateRoute: (settings) => _router.goTo(context: context, settings: settings),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}