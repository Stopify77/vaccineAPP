import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Baby.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_COVID.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Consult.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Influenza.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Vaccine.dart';
import 'package:vaccine_app_project/screens/components/Default_Button.dart';
import 'package:vaccine_app_project/size_config.dart';


//設定問題集的物件
class QuestPageBody extends StatelessWidget{
  const QuestPageBody({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(70)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: getProportionateScreenHeight(3)),
          RichText(
              text: TextSpan(
                  text: mainOfName,style: TextStyle(
                fontSize: getProportionateScreenWidth(80),
                color: mainOfColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "JFopen"
              )
              )
          ),
          SizedBox(height: getProportionateScreenHeight(25),),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "流 感 篇",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestInfluenza(
                          mainOfColor: mainOfColor,
                          mainOfName: "流感篇",
                    )));
          }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "疫 苗 篇",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestVaccine(
                          mainOfColor: mainOfColor,
                          mainOfName: "疫苗篇",
                        )));
          }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "母 嬰 篇",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestBaby(
                          mainOfColor: mainOfColor,
                          mainOfName: "母嬰篇",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "新 冠 肺 炎 篇",
              press: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestCOVID(
                        mainOfColor: mainOfColor,
                        mainOfName: "新冠肺炎篇",
                      )));}),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "諮 詢 專 線",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestConsult(
                          mainOfColor: mainOfColor,
                          mainOfName: "諮詢專線",
                        )));
              }),
        ],
      ),
    );
  }
}