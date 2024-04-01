import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定醫療建議的衛教資料
class InfluenzaAdive extends StatelessWidget{
  const InfluenzaAdive({
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
                  title: "流感快篩哪裡買？一般人也可以自行操作嗎？",
                  subtitle: "診斷流感通常會根據患者發病的症狀來判斷，也會輔以流感快篩（RIDT）來進行病毒檢驗。衛福部公告，流感快篩試劑屬於醫療器材列管，須由專業醫療人員操作，採取患者喉嚨與鼻咽處檢體，滴入快篩試紙測試區塊，再依呈色來判讀是否感染流感，民眾無法自行購買。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "流感快篩哪裡買？\n一般人也可以自行操作嗎？",
                          witchCase: 051,
                          backGroundImage: 'assets/images/back01.png',
                          iconOfColor: Colors.white,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
              child: MessageBox(
                  title: "得了流感可以\n上班上課嗎？",
                  subtitle: "疾管署呼籲，一旦感染流感，應落實不上課、不上班的原則。生病的學生和員工，在未服用退燒藥物的情況下，最好至少退燒後24小時，再返回校園或職場，以防感染他人，加劇流感疫情傳播。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "得了流感可以上班上課嗎？",
                          witchCase: 052,
                          backGroundImage: 'assets/images/back01.png',
                          iconOfColor: Colors.white,
                        )
                    )
                );
              },
            ),
            InkWell( //第三則衛教資料
              child: MessageBox(
                  title: "感染流感怎麼治療？吃什麼可以幫助康復？",
                  subtitle: "考量多數流感患者可以自行痊癒，治療流感時，醫師會以退燒、止咳等支持性療法為主，並適時給予抗病毒藥劑。想要盡早恢復健康，多喝水、多休息是對抗流感病毒的不二法門。",
                  stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "感染流感怎麼治療？\n吃什麼可以幫助康復？",
                          witchCase: 053,
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