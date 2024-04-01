import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../../constants.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定疫苗有效性的衛教資料
class VaccineViald extends StatelessWidget{
  const VaccineViald({
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
            InkWell(  //第一則衛教資料
              child: MessageBox(
                title: "流感疫苗保護力維持多久？\n免疫力不好才需要打疫苗？",
                subtitle: "為什麼流感總是在冬天來襲？敏盛醫院研究副院長江坤俊說明，因為流感病毒耐冷、不耐熱，因此在氣溫較低的冬季較容易傳播。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感疫苗保護力維持多久？\n免疫力不好才需要打疫苗？",
                          witchCase: 141,
                          backGroundImage: "assets/images/back02.png",
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