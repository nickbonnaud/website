import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/routing/app_router.dart';
import 'package:website/routing/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1200, 641),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        initialRoute: Routes.app,
        onGenerateRoute: (settings) => _router.goTo(context: context, settings: settings),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      )
    );
  }
}