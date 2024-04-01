import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Influenza/Influenza_Advice.dart';
import 'package:vaccine_app_project/screens/Influenza/Influenza_Effect.dart';
import 'package:vaccine_app_project/screens/Influenza/Influenza_Symptom.dart';
import 'package:vaccine_app_project/screens/components/Default_Button.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'Influenza_Prevention.dart';
import 'Influenza_Virus.dart';

//設定流感E指通的物件
class InfluenzaPageBody extends StatelessWidget {
  const InfluenzaPageBody({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
    required this.buttonOfName,
    required this.backGroundImage,
    required this.autoSizeHeight,

  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;
  final List<String> buttonOfName;
  final String backGroundImage;
  final double autoSizeHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(90)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // SizedBox(height: getProportionateScreenHeight(3)),
        RichText(
            text: TextSpan(
                text: mainOfName,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(100),
                  color: mainOfColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "JFopen"
                ))),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        DefaultButton(
            mainOfColor: mainOfColor,
            nameOfButton: buttonOfName[0],
            buttonOfHeight: getProportionateScreenHeight(86),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfluenzaVirus(
                          mainOfColor: mainOfColor,
                          mainOfName: "流感病毒",
                      )));
            }),
        DefaultButton(
            mainOfColor: mainOfColor,
            nameOfButton: buttonOfName[1],
            buttonOfHeight: getProportionateScreenHeight(86),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfluenzaSymptom(
                        mainOfColor: mainOfColor,
                        mainOfName: "流感症狀",
                      )));
            }),
        DefaultButton(
            mainOfColor: mainOfColor,
            nameOfButton: buttonOfName[2],
            buttonOfHeight: getProportionateScreenHeight(86),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfluenzaEffect(
                        mainOfColor: mainOfColor,
                        mainOfName: "流感影響",
                      )));
            }),
        DefaultButton(
            mainOfColor: mainOfColor,
            nameOfButton: buttonOfName[3],
            buttonOfHeight: getProportionateScreenHeight(86),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfluenzaPrevention(
                        mainOfColor: mainOfColor,
                        mainOfName: "預防措施",
                      )));
            }),
        DefaultButton(
            mainOfColor: mainOfColor,
            nameOfButton: buttonOfName[4],
            buttonOfHeight: getProportionateScreenHeight(86),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfluenzaAdive(
                        mainOfColor: mainOfColor,
                        mainOfName: "醫療建議",
                      )));
            }),
      ]),
    );
  }
}

