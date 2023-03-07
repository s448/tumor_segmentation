import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumer_segmentation/view/home_page.dart';
import 'package:tumer_segmentation/constants/colors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: mainColor
        ),
      //darkTheme: ThemeData.dark(),
      home:const HomePage(),
    );
  }
}
