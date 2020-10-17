import 'package:flutter/material.dart';
import 'package:flutter_wdm/common/globa.dart';
import 'package:flutter_wdm/provider/config_provider.dart';
import 'package:flutter_wdm/view/pages/home_page.dart';
import 'package:flutter_wdm/view/pages/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  Global.init((){
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()), // 监听自定义的类
      ],
      child: MaterialApp(
        home: SplashPage(),
        routes: {
          "/home": (context) => HomePage(),
        },
      ),
    );
  }
}
