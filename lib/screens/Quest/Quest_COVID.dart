import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定新冠肺炎篇的衛教資料
class QuestCOVID extends StatelessWidget{
  const QuestCOVID({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;
  @override
  Widget build(BuildContext context){
    return SubPage(
      colorStyle: mainOfColor,
      pageName: mainOfName,
      iconOfColor: Colors.white,
      backGroundImage: 'assets/images/back01.png',
      body:Column(
        children: [
          InkWell( //第一則衛教資料
            child: MessageBox(
              title: "新冠肺炎篇 問題集",
              subtitle: "Q1：新冠肺炎感染對孕婦的影響？大多數有症狀的感染者呈現的是類似輕微或中度感冒或流感症狀表現。確診孕婦常見的症狀為咳嗽、發燒、喉嚨痛、味覺喪失、腹瀉、呼吸困難、肌肉痠痛等。",
              stringColor: mainOfColor,
            ),
            onTap: (){
              Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFfiles(
                        mainOfColor: mainOfColor,
                        titleName: "新冠肺炎篇 問題集",
                        witchCase: 241,
                        backGroundImage: 'assets/images/back01.png',
                        iconOfColor: Colors.white,
                      )
                  )
              );
            },
          ),
        ],
      )
    );
  }
}