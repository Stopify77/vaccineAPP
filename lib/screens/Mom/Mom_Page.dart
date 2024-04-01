import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Page_Body.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';

//設定快樂媽咪壓力指數的主要頁面 呼叫lib/screens/Bodys裡面的物件(MomPageBody)
class MomPage extends StatelessWidget{
  static String routeName = '/MomPage';
  @override
  Widget build(BuildContext context){
    return DefaultPage(
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
        press: (){
          Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
        },
      body: const MomPageBody(
        mainOfColor: kColorStyle222,
        mainOfName: "快樂媽咪壓力指數",
        iconOfColor: kColorStyle444,)
    );
  }
}