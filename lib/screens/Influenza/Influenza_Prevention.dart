import 'package:flutter/material.dart';
import '../components/Sub_Page.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定預防措施的衛教資料
class InfluenzaPrevention extends StatelessWidget{
  const InfluenzaPrevention({
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
              child:  MessageBox(
                  title: "流感病毒之預防措施",
                  subtitle: "預防保健 (一)、衛教宣導 1.加強個人衛生習慣，勤洗手，避免接觸傳染。2.注意呼吸道衛生及咳嗽禮節，戴口罩及保持社交距離，以避免感染及病毒傳播。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感病毒之預防措施",
                          witchCase: 041,
                          backGroundImage: 'assets/images/back01.png',
                          iconOfColor: Colors.white,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
              child: MessageBox(
                  title: "流感預防怎麼做？",
                  subtitle: "勤洗手、雙手不碰眼口鼻、減少出入人潮眾多的室內場所、打招呼時拱手不握手、打噴嚏掩口鼻、時常量體溫、養成良好的作息與運動習慣、定期清潔居家環境、保持室內環境通風、配戴口罩，都是降低確診流感的重要關鍵。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感預防怎麼做？",
                          witchCase: 042,
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