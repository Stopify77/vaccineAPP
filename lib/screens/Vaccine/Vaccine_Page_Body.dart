import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Reaction.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Safety.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Time.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Type.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Vaild.dart';
import 'package:vaccine_app_project/screens/components/Default_Button.dart';
import 'package:vaccine_app_project/size_config.dart';


//設定疫苗E指通的物件
class VaccinePageBody extends StatelessWidget{
  const VaccinePageBody({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(90)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: getProportionateScreenHeight(3)),
          RichText(
              text: TextSpan(
                  text: mainOfName,style: TextStyle(
                fontSize: getProportionateScreenWidth(100),
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
              nameOfButton: "疫 苗 種 類",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VaccineType(
                          mainOfColor: mainOfColor,
                          mainOfName: "疫苗種類",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "接 種 時 機",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VaccineTime(
                          mainOfColor: mainOfColor,
                          mainOfName: "接種時機",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "疫 苗 安 全 性",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VaccineSafety(
                          mainOfColor: mainOfColor,
                          mainOfName: "疫苗安全性",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "疫 苗 有 效 性",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VaccineViald(
                          mainOfColor: mainOfColor,
                          mainOfName: "疫苗有效性",
                        )));
              }),
          DefaultButton(
              mainOfColor: mainOfColor,
              buttonOfHeight: getProportionateScreenHeight(86),
              nameOfButton: "不 良 反 應 案 例",
              press: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VaccineReaction(
                          mainOfColor: mainOfColor,
                          mainOfName: "不良反應案例",
                        )));

              }),
        ],
      ),
    );
  }
}
