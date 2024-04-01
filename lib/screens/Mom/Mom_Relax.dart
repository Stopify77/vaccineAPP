import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/components/RelaxPost.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class MomRelax extends StatelessWidget{
  const MomRelax({
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
    var space = MediaQuery.of(context).size.height *0.03;
    return SubPage(
      colorStyle: mainOfColor,
      pageName: mainOfName,
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(42),
                vertical: getProportionateScreenHeight(25)),
              child: Center(
                  child: Text(
                    "    來看看有趣的圖文作家們，舒緩一下心情吧！～",
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(24),
                        color: kTextColor),
                  )
              )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
            child: Column(
              children: [
                SizedBox(height: space,),
                RelaxPost(
                    posterName: "八耐舜子",
                    posterIntroduce: "謝謝你們不斷分享幽默的笑話和故事給我，我才能將湧現的靈感一筆一筆繪製出屬於大家的精彩人生。/ ———- by 八耐舜子",
                    borderColor: mainOfColor,
                    posterURL: "https://www.facebook.com/banai.shunz?locale=zh_TW"),
                SizedBox(height: space,),
                RelaxPost(
                    posterName: "我是馬克",
                    posterIntroduce: "我是馬克，你也不見得不是馬克。",
                    borderColor: mainOfColor,
                    posterURL: "https://www.facebook.com/markleeblog?locale=zh_TW"),
                SizedBox(height: space,),
                RelaxPost(
                    posterName: "Sana殺哪～",
                    posterIntroduce: "SANA，不定時更新漫畫&月份桌布~",
                    borderColor: mainOfColor,
                    posterURL: "https://www.facebook.com/sana217wu?locale=zh_TW")
            ],),
          )

        ],
      ),
    );
  }
}