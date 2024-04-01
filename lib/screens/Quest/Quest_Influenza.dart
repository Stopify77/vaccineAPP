import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定流感篇的衛教資料
class QuestInfluenza extends StatelessWidget{
  const QuestInfluenza({
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
                title: "季節性流感防治",
                subtitle: "Q1：哪裡可以查到流感疫情相關資訊？可參閱疾病管制署於流感季每週出刊之「流感速訊」(https://gov.tw/mzN)，或疾病管制署傳染病統計資料查詢系統(https://nidss.cdc.gov.tw/)。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "季節性流感防治",
                          witchCase: 211,
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