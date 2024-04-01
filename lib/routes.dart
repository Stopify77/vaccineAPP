import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Calendar/Calendar_Page.dart';
import 'package:vaccine_app_project/screens/Influenza/Influenza_Page.dart';
import 'package:vaccine_app_project/screens/Log_in/login_screen.dart';
import 'package:vaccine_app_project/screens/Main_Page/main_page.dart';
import 'package:vaccine_app_project/screens/Main_Page/message_page.dart';
import 'package:vaccine_app_project/screens/Map/Map_Page.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Page.dart';
import 'package:vaccine_app_project/screens/Report/Report_Day.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Page.dart';
import 'package:vaccine_app_project/screens/Report/Report_Page.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Page.dart';

import 'constants.dart';


//設定各個主要的頁面的路由名稱 以便使用pushNamed的Navigation
final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => const MainPage(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  InfluenzaPage.routeName: (context) => InfluenzaPage(),
  VaccinePage.routeName: (context) => VaccinePage(),
  MapPage.routeName: (context) => MapPage(),
  CalendarPage.routeName: (context) => const CalendarPage(),
  MomPage.routeName: (context) => MomPage(),
  ReportPage.routeName: (context) => ReportPage(),
  QuestPage.routeName: (context) => QuestPage(),
  MessagePage.routeName: (context)=> const MessagePage(),
  ReportDay.routeName: (context) => const ReportDay(mainOfColor: kColorStyle222,mainOfName: "接種日期",),
};