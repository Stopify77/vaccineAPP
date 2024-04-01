import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

//設定諮詢專線的頁面
class QuestConsult extends StatelessWidget{
  const QuestConsult({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context){
    return SubPage(
      colorStyle: mainOfColor,
      pageName: mainOfName,
      iconOfColor: Colors.white,
      backGroundImage: 'assets/images/back01.png',
      body: SafeArea(
        child: Column(
            children:[
              Text("掃描以下QRcode加入Line群組",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(24)
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Image.asset("assets/images/QRcode.png",
                      scale: 0.01,
                      fit: BoxFit.contain,
                    )),
              ),
              Text("或點擊下方連接加入Line群組",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(24)
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
                child: Container(
                  width: getProportionateScreenWidth(450),
                  height: getProportionateScreenHeight(40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "https://lin.ee/U1E7EdD",
                            style: TextStyle(
                              fontSize:getProportionateScreenWidth(36),
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                            ),
                            recognizer: TapGestureRecognizer().. onTap=() {
                              final Uri url =Uri.parse("https://lin.ee/U1E7EdD");
                              _launchUrl(url);
                            }
                        )),
                  ),
                ),
              ),
            ]),
      )
    );
  }
}