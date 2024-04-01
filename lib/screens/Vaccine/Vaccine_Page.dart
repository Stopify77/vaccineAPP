import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Page_Body.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';

//設定疫苗E指通的主要頁面 呼叫lib/screens/Bodys裡面的物件(VaccinePageBody)
class VaccinePage extends StatelessWidget{
  static String routeName = '/VaccinePage';
  @override
  Widget build(BuildContext context){
    return DefaultPage(
      iconOfColor: kColorStyle333,
      backGroundImage: 'assets/images/back02.png',
      press: (){
        Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
      },
      body: const VaccinePageBody(
        mainOfColor: kColorStyle111,
        mainOfName: "疫苗E指通",
      ),
    );
  }
}