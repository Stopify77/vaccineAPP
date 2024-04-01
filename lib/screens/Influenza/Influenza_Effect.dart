import 'package:flutter/material.dart';
import '../components/Sub_Page.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定流感影響的衛教資料
class InfluenzaEffect extends StatelessWidget{
  const InfluenzaEffect({
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
                  title: "懷孕與流感",
                  subtitle: "流感(Influenza)是一種由流感病毒所引起的急性呼吸道疾病。流感病毒依照其核蛋白(nucleoprotein)的不同可區分為A、B、C三型。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "懷孕與流感",
                          witchCase: 031,
                          backGroundImage: 'assets/images/back01.png',
                          iconOfColor: Colors.white,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
              child:  MessageBox(
                  title: "流感哪些人要特別小心？",
                  subtitle: "衛福部之所以提醒大家要對流感提高警覺，除了人人都有可能得到流感，也是因流感具有爆發流行快速、散播範圍廣泛、併發症嚴重等特性。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感哪些人要特別小心？",
                          witchCase: 032,
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