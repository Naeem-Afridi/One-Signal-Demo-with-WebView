import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onesignaldemo/SplashScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF5AB58),
  ));
  OneSignal.shared
      .init("242c5fac-4afc-4091-9e9e-698beebe7d40", iOSSettings: null);
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  String title = "title";
  String content = "content";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        title = notification.payload.title;
        content = notification.payload.body;
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
    });
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'SouledOut',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://souledout.shop',
            onPageFinished: (String url) {
              setState(() {
                //hide you progressbar here
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            SpinKitFadingCircle(
              color: Color(0xFFF5AB58),
              size: 50.0,
              controller: AnimationController(
                vsync: this,
                duration: const Duration(milliseconds: 1200),
              ),
            )
          else
            Stack()
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
