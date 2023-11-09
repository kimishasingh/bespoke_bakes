import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String appTitle = 'bespoke.bakes';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF76C6C5),
          secondary: const Color(0xFFFC4C69),
        ),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Color(0xFF76C6C5),
            fontSize: 18,
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Color(0xFF76C6C5),
            fontSize: 16,
          ),
          labelSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Color(0xFF76C6C5),
          fontSize: 14,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.grey,
            fontSize: 16,
          ),
          displayLarge: TextStyle(
              color: Color(0xFFFC4C69),
              fontWeight: FontWeight.w400
          ),
        )
      ),

      home: const Scaffold(
        //appBar: AppBar(title: const Text(appTitle)),
        body: LoginPage(),
      ),
    );
  }
}