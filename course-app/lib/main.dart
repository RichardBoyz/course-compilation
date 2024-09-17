import 'package:course/cache/cache.dart';
import 'package:course/services/network_config.dart';
import 'package:flutter/material.dart';
import 'router.dart';

Future<void> main() async {
  await AppCache.init();
  String? token = AppCache.token;
  Network.init(token);
  runApp(MyApp(
    initialRoute: token == null ? '/' : '/lobby',
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: initialRoute,
    );
  }
}
