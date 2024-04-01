import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Drawing.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Games.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Lights.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Relax.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Test.dart';
import 'package:vaccine_app_project/screens/components/Default_Button.dart';
import 'package:vaccine_app_project/size_config.dart';


//設定快樂媽咪指數的物件
class MomPageBody extends StatelessWidget{
  const MomPageBody({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
    required this.iconOfColor,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;
  final Color iconOfColor;

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
              nameOfButton: "壓 力 測 試",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MomTest(
                          mainOfColor: mainOfColor,
                          mainOfName: "壓力測試",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "壓 力 燈 號",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MomLights(
                          mainOfColor: mainOfColor,
                          mainOfName: "壓力燈號",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "紓 壓 小 遊 戲",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MomGames(
                          mainOfColor: mainOfColor,
                          mainOfName: "紓壓小遊戲",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "紓 壓 小 品",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MomRelax(
                          mainOfColor: mainOfColor,
                          mainOfName: "紓壓小品",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "塗 鴉 區",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MomDrawing(
                          mainOfColor: mainOfColor,
                          mainOfName: "塗鴉區",
                        )));
              }),
        ],
      ),
    );
  }
}