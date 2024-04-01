import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vaccine_app_project/constants.dart';
import '../../size_config.dart';
import 'PDF_Page.dart';
import 'package:url_launcher/url_launcher.dart';

//讀取PDF檔案的物件
class PDFfiles extends StatelessWidget{
  const PDFfiles({
    Key? key,
    required this.mainOfColor,
    required this.titleName,
    required this.witchCase,
    required this.backGroundImage,
    required this.iconOfColor,

  }) : super(key: key);

  final Color mainOfColor;
  final Color iconOfColor;
  final String titleName;
  final double witchCase;
  final String backGroundImage;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context){
    String openFile="";
    String sourceUrl="";
    double zoomSize=1.35;
    Offset setting= Offset(MediaQuery.of(context).size.width*0.12, MediaQuery.of(context).size.height*0.052);
    switch(witchCase){ //判斷點擊的文章為哪則文章 設定各種PDF的路徑
      case 011:
        openFile="assets/pdf/influenza/1-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/Page/HMC9qDI4FA-gDrbcnFlXgg";
      case 012:
        openFile="assets/pdf/influenza/1-2.pdf";
        sourceUrl="https://www.taic.mohw.gov.tw/public/hygiene/ee70735722b8beed7d3b8f2259546233.pdf";
      case 021:
        openFile="assets/pdf/influenza/2-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/Page/HMC9qDI4FA-gDrbcnFlXgg";
      case 031:
        openFile="assets/pdf/influenza/3-1.pdf";
        zoomSize=1.15;
        setting=const Offset(25, 10);
      case 032:
        openFile="assets/pdf/influenza/3-2.pdf";
        sourceUrl="https://ynews.page.link/EEHEU";
      case 041:
        openFile="assets/pdf/influenza/4-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/Page/HMC9qDI4FA-gDrbcnFlXgg";
      case 042:
        openFile="assets/pdf/influenza/4-2.pdf";
        sourceUrl="https://ynews.page.link/EEHEU";
      case 051:
        openFile="assets/pdf/influenza/5-1.pdf";
        sourceUrl="https://www.bh.ntuh.gov.tw/english/?aid=512&pid=0&page_name=detail&iid=4";
      case 052:
        openFile="assets/pdf/influenza/5-2.pdf";
        sourceUrl="https://ynews.page.link/EEHEU";
      case 053:
        openFile="assets/pdf/influenza/5-3.pdf";
        sourceUrl="https://ynews.page.link/EEHEU";
      case 111:
        openFile="assets/pdf/vaccine/1-1.pdf";
        sourceUrl="https://ynews.page.link/EEHEU";
      case 112:
        openFile="assets/pdf/vaccine/1-2.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/MPage/JNTC9qza3F_rgt9sRHqV2Q";
      case 121:
        openFile="assets/pdf/vaccine/2-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/MPage/JNTC9qza3F_rgt9sRHqV2Q";
      case 131:
        openFile="assets/pdf/vaccine/3-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/MPage/JNTC9qza3F_rgt9sRHqV2Q";
      case 141:
        openFile="assets/pdf/vaccine/4-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/QAPage/RJ6gxWhhbZIqMrTMBlWPlQ";
      case 151:
        openFile="assets/pdf/vaccine/5-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/Page/LnrbufSY9uTyIprhOZ15NA";
      case 152:
        openFile="assets/pdf/vaccine/5-2.pdf";
        sourceUrl="https://udn.com/news/story/7266/7499494";
      case 211:
        openFile="assets/pdf/quest/1-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/QAPage/DQWXG19u2cXMH1jwGKXHug";
      case 221:
        openFile="assets/pdf/quest/2-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/MPage/zUdLuQ_MPMEZqw2IkXy-Ug";
      case 222:
        openFile="assets/pdf/quest/2-2.pdf";
        sourceUrl="https://www.cdc.gov.tw/Category/QAPage/YgeC_ca-wDJqW2fnH6CLdg";
      case 231:
        openFile="assets/pdf/quest/3-1.pdf";
        sourceUrl="https://www.cdc.gov.tw/Uploads/a96f2568-a721-41a1-b681-9430da4f79ca.pdf";
      case 241:
        openFile="assets/pdf/quest/4-1.pdf";
        sourceUrl="https://mammy.hpa.gov.tw/Home/NewsKBContent?id=2347&type=01";

    }
    return PDFPage(
      colorStyle: mainOfColor,
      pageName: titleName,
      iconOfColor: iconOfColor,
      backGroundImage: backGroundImage,
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15),vertical: getProportionateScreenHeight(10)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(35)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    child: SfPdfViewer.asset(openFile,
                      initialZoomLevel: zoomSize,
                      initialScrollOffset: setting,
                      canShowScrollHead: false,
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(25)),
              child: RichText(
              overflow: TextOverflow.ellipsis,
                maxLines: 2,
                text: TextSpan(
                    children: [
                      TextSpan(
                          text:"資料來源：",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height*0.03,
                        color: kTextColor,
                          backgroundColor: Colors.white
                        )
                      ),
                  TextSpan(
                      text: "$sourceUrl",
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: MediaQuery.of(context).size.height *0.03
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    final Uri url =Uri.parse(sourceUrl);
                    _launchUrl(url);

                  })
              ],)
                         ),
            )
          ],
        ),
      ),
    );
  }
}