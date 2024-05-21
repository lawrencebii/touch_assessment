import 'package:flutter/material.dart';
import 'package:touch_assessment/features/Home/Views/home_screen.dart';
import 'package:touch_assessment/state_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StateManagementClass(
      child: MaterialApp(
        title: 'Touch Inspiration Assessment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
