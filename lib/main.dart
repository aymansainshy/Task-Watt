import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_watt/di.dart' as injector;
import 'package:task_watt/features/auth/views/login_view.dart';
import 'package:task_watt/features/map/views/main_map_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injector.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task 101',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.zero,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.background),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  // side: BorderSide(color: Colors.red)
                ),
              ),
            ),
          )),
      home: const LoginView(),
    );
  }
}
