import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Message_Box.dart';
import '../components/Sub_Page.dart';
import '../components/PDF_files.dart';

//設定流感病毒的衛教資料
class InfluenzaVirus extends StatelessWidget{
  const InfluenzaVirus({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;
  @override
  Widget build(BuildContext context){
    return
      SubPage(
        colorStyle: mainOfColor,
        pageName: mainOfName,
        iconOfColor: Colors.white,
        backGroundImage: 'assets/images/back01.png',
        body: Column(
          children: [
            InkWell( //第一則衛教資料
                child:  MessageBox(
                    title: "流感病毒之疾病介紹",
                    subtitle: "流感為急性病毒性呼吸道疾病，致病原為流感病毒，常引起發燒、咳嗽、頭痛、肌肉酸痛、疲倦、流鼻水、喉嚨痛等，但通常在1週內會康復。",
                  stringColor: mainOfColor,
                ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                            mainOfColor: mainOfColor,
                            titleName: "流感病毒之疾病介紹",
                            witchCase: 011,
                          backGroundImage: 'assets/images/back01.png',
                          iconOfColor: Colors.white,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
                child: MessageBox(
                    title: "流感是什麼？跟感冒差在哪？",
                    subtitle: "我們常聽到的流感，其實是一種急性病毒性呼吸道疾病，致病原為流感病毒，病毒分為A、B、C、D四種型別，其中A型和B型流感可以引發季節性流行，常見的H3N2、H1N1流感便屬之。流感是具有明顯季節性的流行疾病，疫情的發生常有周期性。",
                  stringColor: mainOfColor,
                ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                            mainOfColor: mainOfColor,
                            titleName: "流感是什麼？跟感冒差在哪？",
                          witchCase: 012,
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


