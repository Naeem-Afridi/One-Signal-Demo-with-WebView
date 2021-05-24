import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onesignaldemo/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return SplashScreenState();
  }
}

bool isDarkMode = false;

class SplashScreenState extends State<SplashScreen> {
  ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            Text('Geniune Home Cooked Meals')
          ],
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }
}
