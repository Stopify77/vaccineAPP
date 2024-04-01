import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../../constants.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定接種時機的衛教資料
class VaccineTime extends StatelessWidget{
  const VaccineTime({
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
                title: "公費疫苗可與新冠疫苗一起打？",
                subtitle: "疾管署說明，6個月以上嬰幼兒接種劑量為0.5 mL（各家廠牌適用年齡不同）；未滿9歲兒童若初次接種，應接種2劑且間隔4週以上、每次接種0.5mL。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "公費疫苗可與新冠疫苗一起打？",
                          witchCase: 121,
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