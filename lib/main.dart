import 'package:flutter/material.dart';
import 'package:meteo_app/screens/loading_screen.dart';
import 'package:meteo_app/utilities/dismiss_keyboard.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [DismissKeyboardNavigationObserver()],
      home: LoadingScreen(),
    );
  }
}
