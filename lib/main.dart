import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaccine_app_project/firebase_api.dart';
import 'package:vaccine_app_project/screens/Log_in/login_screen.dart';
import 'package:vaccine_app_project/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //設定APP畫面的角度 設定為垂直 無法透過反轉畫面旋轉APP
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaccination App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "JFopen",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
              bodyMedium: TextStyle(
                  color: Color(0xFFE8A2BA)
              ),
              bodyLarge: TextStyle(
                  color: Color(0xFFE8A2BA)
              ),
              bodySmall: TextStyle(
                  color: Color(0xFFE8A2BA)
              ),
        ),
      ),
      navigatorKey: navigatorKey,
      initialRoute: LoginScreen.routeName, //初始化頁面為登入畫面
      routes: routes, //將所有頁面路徑輸入
      // home: MainPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


