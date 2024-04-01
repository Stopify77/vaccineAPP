import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Map/Map_Page_Body.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';

import 'Map_Page_Body.dart';

//設定接種地圖的主要頁面 呼叫lib/screens/Bodys裡面的物件(MapPageBody)
class MapPage extends StatelessWidget{
  static String routeName = '/MapPage';
  @override
  Widget build(BuildContext context){
    return
       DefaultPage(
         iconOfColor: kColorStyle333,
         backGroundImage: 'assets/images/back03.png',
         body: const MapPageBody(mainOfColor: kColorStyle111, mainOfName: "接種地圖",),
         press: () {
          Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
        },
       );
  }
}