import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Report/Report_Body.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';

//設定接種回報的主要頁面 呼叫lib/screens/Bodys裡面的物件(ReportPageBody)
class ReportPage extends StatelessWidget{
  static String routeName = '/ReportPage';
  @override
  Widget build(BuildContext context){
    return DefaultPage(
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
      press: (){
        Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
      },
      body: const ReportPageBody(mainOfColor: kColorStyle222, mainOfName: "接種回報"),
    );
  }
}