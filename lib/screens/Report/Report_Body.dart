import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Report/Report_Day.dart';
import 'package:vaccine_app_project/screens/Report/Report_Feedback.dart';
import 'package:vaccine_app_project/screens/Report/Report_Satisfaction.dart';
import 'package:vaccine_app_project/screens/Report/Report_Survey.dart';
import 'package:vaccine_app_project/screens/components/Default_Button.dart';
import 'package:vaccine_app_project/size_config.dart';

//設定接種回報的物件
class ReportPageBody extends StatelessWidget{
  const ReportPageBody({
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
              buttonOfHeight: getProportionateScreenHeight(110),
              nameOfButton: "接 種 日 期",
              press: (){
                Navigator.pushNamed(
                    context, ReportDay.routeName);
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(110),
              nameOfButton: "接 種 反 應 調 查",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportSurvey(
                          mainOfColor: mainOfColor,
                          mainOfName: "接種反應調查",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(110),
              nameOfButton: "滿 意 度",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportSatisfaction(
                          mainOfColor: mainOfColor,
                          mainOfName: "滿意度",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(110),
              nameOfButton: "意 見 回 饋",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportFeedback(
                          mainOfColor: mainOfColor,
                          mainOfName: "意見回饋",
                        )));
              }),
        ],
      ),
    );
  }
}