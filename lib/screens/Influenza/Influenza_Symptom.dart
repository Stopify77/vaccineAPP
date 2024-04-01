import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/PDF_files.dart';
import '../components/Sub_Page.dart';
import '../components/Message_Box.dart';

//設定流感症狀的衛教資料
class InfluenzaSymptom extends StatelessWidget{
  const InfluenzaSymptom({
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
                title: "流感病毒之臨床症狀",
                subtitle: "感染流感後主要症狀為發燒、頭痛、肌肉酸痛、疲倦、流鼻水、喉嚨痛及咳嗽等，部分患者伴有腹瀉、嘔吐等症狀。多數患者在發病後會自行痊癒，少數患者可能出現嚴重併發症，常見併發症為肺炎、腦炎、心肌炎及其他嚴重之繼發性感染或神經系統疾病等。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感病毒之臨床症狀",
                          witchCase: 021,
                          backGroundImage: "assets/images/back01.png",
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