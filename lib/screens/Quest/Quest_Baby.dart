import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';

import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定母嬰篇的衛教資料
class QuestBaby extends StatelessWidget{
  const QuestBaby({
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
      body: Column(
        children: [
          InkWell( //第一則衛教資料
            child: MessageBox(
              title: "母嬰篇 問題集",
              subtitle: "Q1：112年流感疫苗接種計畫實施對象包含之孕婦及6個月內嬰兒之父母，其認定方式為何？1.	已領取國民健康署編印「孕婦健康手冊」之懷孕婦女，若懷孕初期產檢院所尚未發給孕婦健康手冊，則可檢附診斷證明書。",
              stringColor: mainOfColor,
            ),
            onTap: (){
              Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFfiles(
                        mainOfColor: mainOfColor,
                        titleName: "母嬰篇 問題集",
                        witchCase: 231,
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