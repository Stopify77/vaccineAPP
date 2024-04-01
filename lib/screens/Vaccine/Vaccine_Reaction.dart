import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import '../../constants.dart';
import '../components/Message_Box.dart';
import '../components/PDF_files.dart';

//設定不良反應案例的衛教資料
class VaccineReaction extends StatelessWidget{
  const VaccineReaction({
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
                  title: "接種流感疫苗後，如何知道自己是否出現「不良反應」？",
                  subtitle: "一般人在接種疫苗後，如何知道有不良反應？流感疫苗接種後，其症狀可以分成為兩種：局部反應（注射的部位任何反應變化）與全身反應（非注射部位引發的症狀變化）。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "接種流感疫苗後，\n如何知道自己是否出現「不良反應」？",
                          witchCase: 151,
                          backGroundImage: 'assets/images/back02.png',
                          iconOfColor: kColorStyle333,
                        )
                    )
                );
              },
            ),
            InkWell( //第二則衛教資料
              child:  MessageBox(
                  title: "公費流感疫苗不良反應8件 衛福部長薛瑞元：沒有高端",
                  subtitle: "公費流感疫苗10月2日開打，其中因為今年公費疫苗廠牌包含高端，因此引起民眾憂心甚至出現躲打潮。衛福部長薛瑞元今針對流感疫苗施打狀況以及美豬爭議說明。",
                stringColor: mainOfColor,
              ),
              onTap: (){
                Navigator.push( //將頁面切換到讀取文章的頁面 並且開啟相對應的PDF檔案
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFfiles(
                          mainOfColor: mainOfColor,
                          titleName: "公費流感疫苗不良反應8件\n衛福部長薛瑞元：沒有高端",
                          witchCase: 152,
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