import 'package:corona_api/view/CountriesList.dart';
import 'package:corona_api/view/CountryDetail.dart';
import 'package:corona_api/view/splashScreen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark
      ),
      home: SplashScreen(),
    );
  }
}
