import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定疫苗篇的衛教資料
class QuestVaccine extends StatelessWidget{
  const QuestVaccine({
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
                title: "孕婦接種流感\n疫苗常見問答",
                subtitle: "Q1：孕婦或準備懷孕的婦女是否可以接種流感疫苗？可以，孕婦為世界衛生組織建議的流感疫苗優先接種對象之一，也是我國公費流感疫苗接種對象。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "孕婦接種流感\n疫苗常見問答",
                          witchCase: 221,
                          backGroundImage: "assets/images/back01.png",
                          iconOfColor: Colors.white,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
              child: MessageBox(
                title: "流感抗病毒藥劑",
                subtitle:
                    "Q1：流感疫苗跟流感抗病毒藥劑有甚麼不同？流感疫苗可預防感染流感，有不活化疫苗、活性減毒疫苗等種類，藉由刺激人體產生抗體對抗病毒，使人體免於感染流感或降低感染發病後的嚴重程度，保護力約可維持半年至1年；",
                stringColor: mainOfColor,
              ),
              onTap: () {
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                              mainOfColor: mainOfColor,
                              titleName: "流感抗病毒藥劑",
                              witchCase: 222,
                              backGroundImage: "assets/images/back01.png",
                              iconOfColor: Colors.white,
                            )
                    )
                );
              },
            )
          ],
        )
    );
  }
}