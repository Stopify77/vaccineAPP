import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Calendar/Calendar_Page.dart';
import 'package:vaccine_app_project/screens/Influenza/Influenza_Page.dart';
import 'package:vaccine_app_project/screens/Main_Page/components/Functioning_Cards.dart';
import 'package:vaccine_app_project/screens/Map/Map_Page.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Page.dart';
import 'package:vaccine_app_project/screens/Quest/Quest_Page.dart';
import 'package:vaccine_app_project/screens/Report/Report_Page.dart';
import 'package:vaccine_app_project/screens/Vaccine/Vaccine_Page.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class FunctionList extends StatelessWidget {
  const FunctionList({
    Key? key,
    required this.currentWidth,
  }) : super(key: key);
  final double currentWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                children: [
                  FunctioningCards( //流感E指通
                    press: () async { //計算流感E指通點擊次數
                      Navigator.pushNamed(context, InfluenzaPage.routeName);
                      await http.post(
                        Uri.parse('${VMURL}addCTR.php'),
                        body: {
                          'name': 'influenza_ctr',
                        },
                      );
                    },
                    imageAssets: "assets/images/011.png",
                    currentWidth: currentWidth,
                  ),
                  FunctioningCards( //接種地圖
                    press: () async { //計算接種地圖點擊次數
                      Navigator.pushNamed(context, MapPage.routeName);
                      await http.post(
                        Uri.parse('${VMURL}addCTR.php'),
                        body: {
                          'name': 'Map_ctr',
                        },
                      );
                    },
                    imageAssets: "assets/images/055.png",
                    currentWidth: currentWidth,
                  ),
                  FunctioningCards( //接種回報
                    press: () async { //計算接種回報點擊次數
                      Navigator.pushNamed(context, ReportPage.routeName);
                      await http.post(
                        Uri.parse('${VMURL}addCTR.php'),
                        body: {
                          'name': 'report_ctr',
                        },
                      );
                    },
                    imageAssets: "assets/images/033.png",
                    currentWidth: currentWidth,
                  ),
                ]),
            Column(
              children: [
                FunctioningCards( //疫苗E指通
                  press: () async { //計算疫苗E指通點擊次數
                    Navigator.pushNamed(context, VaccinePage.routeName);
                    await http.post(
                      Uri.parse('${VMURL}addCTR.php'),
                      body: {
                        'name': 'vaccine_ctr',
                      },
                    );
                  },
                  imageAssets: "assets/images/022.png",
                  currentWidth: currentWidth,
                ),
                FunctioningCards(  //快樂媽咪壓力指數
                  press: () async { //計算快樂媽咪壓力指數點擊次數
                    Navigator.pushNamed(context, MomPage.routeName);
                    await http.post(
                      Uri.parse('${VMURL}addCTR.php'),
                      body: {
                        'name': 'mom_ctr',
                      },
                    );
                  },
                  imageAssets: "assets/images/044.png",
                  currentWidth: currentWidth,
                ),
                FunctioningCards( //問題集
                  press: () async {
                    Navigator.pushNamed(context, QuestPage.routeName);
                    await http.post( //計算問題集點擊次數
                      Uri.parse('${VMURL}addCTR.php'),
                      body: {
                        'name': 'question_ctr',
                      },
                    );
                  },
                  imageAssets: "assets/images/066.png",
                  currentWidth: currentWidth,
                ),
              ],
            ),
          ],
        ),
        FunctioningCards( //行事曆
          press: () async {
            Navigator.pushNamed(context, CalendarPage.routeName);
            await http.post( //計算行事曆點擊次數
              Uri.parse('${VMURL}addCTR.php'),
              body: {
                'name': 'calendar_ctr',
              },
            );
          },
          imageAssets: "assets/images/077.png",
          currentWidth: currentWidth*2,
        ),
      ],
    );
  }
}