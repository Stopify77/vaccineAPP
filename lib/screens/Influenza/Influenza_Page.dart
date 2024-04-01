import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Influenza/Inlfuenza_Page_Body.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';

import '../../size_config.dart';

//設定流感E指通的主要頁面 呼叫lib/screens/Bodys裡面的物件(InfluenzaPageBody)
class InfluenzaPage extends StatelessWidget{
  static String routeName = '/InfluenzaPage';
  @override
  Widget build(BuildContext context){
    return  DefaultPage(
      iconOfColor: Colors.white,
      backGroundImage: 'assets/images/back01.png',
      press: (){
        Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
      },
        body:
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          double height = constraints.maxHeight/5 - getProportionateScreenHeight(150);
          return InfluenzaPageBody(
            mainOfColor: kColorStyle333,
            mainOfName: "流感E指通",
            buttonOfName: const ["流 感 病 毒","流 感 症 狀","流 感 影 響","預 防 措 施","醫 療 建 議"],
            backGroundImage: 'assets/images/back01.png',
            autoSizeHeight: height,
          ); //呼叫lib/screens/Main_Page/components裡面的Function_List物件
        }),
    );
  }
}