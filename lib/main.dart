import 'package:flutter/material.dart';
import 'package:todo/features/ui/home/home_view.dart';
import 'package:todo/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Palette.themeColor,
      ),
      home: const HomeScreenWidget(),
    );
  }
}
