import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color.fromRGBO(0, 0, 0, 0.1)
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes App',
      initialRoute: '/',
      routes: {
        '/'    : ( BuildContext context ) => HomePage(),
      },
    );
  }
}