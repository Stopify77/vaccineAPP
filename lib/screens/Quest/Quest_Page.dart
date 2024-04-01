import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Page_Body.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';

//設定問題集的主要頁面 呼叫lib/screens/Bodys裡面的物件(QuestPageBody)
class QuestPage extends StatelessWidget{
  static String routeName = '/QuestPage';
  @override
  Widget build(BuildContext context){
    return DefaultPage(
      iconOfColor: Colors.white,
      backGroundImage: 'assets/images/back01.png',
      press: (){
        Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
      },
      body: const QuestPageBody(mainOfColor: kColorStyle333, mainOfName: "問題集"),
    );
  }
}