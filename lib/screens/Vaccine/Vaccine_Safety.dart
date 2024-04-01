import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../../constants.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定疫苗安全性的衛教資料
class VaccineSafety extends StatelessWidget{
  const VaccineSafety({
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
              child: MessageBox(
                title: "流感疫苗的必備常識",
                subtitle: "流感疫苗提供最高八成的保護力對抗流感最有效的方法就是接種疫苗。「依據衛福部食藥署公布，目前台灣有上市許可證的流感疫苗，依內含疫苗株成分不同，分為含3種疫苗株（2種A型、1種B型）的三價流感疫苗，",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感疫苗的必備常識",
                          witchCase: 131,
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