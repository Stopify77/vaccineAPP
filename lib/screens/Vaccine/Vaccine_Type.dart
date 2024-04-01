import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../../constants.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定疫苗種類的衛教資料
class VaccineType extends StatelessWidget{
  const VaccineType({
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
        iconOfColor: kColorStyle333,
        backGroundImage: 'assets/images/back02.png',
        body: Column(
          children: [
            InkWell( //第一則衛教資料
              child:  MessageBox(
                  title: "流感疫苗何時打？有副作用嗎？",
                  subtitle: "預防流感，定期接種流感疫苗是最有效的方式。由於每年流感疫苗株成分均可能改變，且接種後免疫力一般無法持續超過一年，建議每年皆須接種。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感疫苗何時打？\n有副作用嗎？",
                          witchCase: 111,
                          backGroundImage: 'assets/images/back02.png',
                          iconOfColor: kColorStyle333,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
              child:  MessageBox(
                  title: "流感疫苗可以選廠牌嗎？",
                  subtitle: "今年政府採購的流感疫苗有哪些廠牌？適用年齡為何？可否指定廠牌？疾管署解釋，今年提供之公費疫苗共有4家廠牌，疫苗配送採「先到貨、先鋪貨、先使用」原則",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感疫苗可以選廠牌嗎？",
                          witchCase: 112,
                          backGroundImage: 'assets/images/back02.png',
                          iconOfColor: kColorStyle333,
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