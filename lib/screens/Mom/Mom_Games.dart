import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Game_Introduce.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import '../../constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MomGames extends StatelessWidget{
  const MomGames({
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
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GameBox(
                          gameName: "五子棋",
                          gameIntroduce: "五子棋是一種棋盤遊戲，兩名玩家輪流在橫、縱、斜線上落子，目標是先在棋盤上形成五顆連珠的棋子，獲得勝利。",
                          borderColor: mainOfColor,
                          gameURL: "https://www.olgclub.com/play-10325.html"
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      GameBox(
                          gameName: "拼圖",
                          gameIntroduce: "拼圖是一種遊戲或娛樂活動，通常包含碎片狀的零件，玩家需要將這些碎片組合在一起，還原出完整的圖案或圖像。",
                          borderColor: mainOfColor,
                          gameURL: "https://www.olgclub.com/play-12754.html"
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      GameBox(
                          gameName: "創意塗色本",
                          gameIntroduce: "創意塗色本是一種愉悅的藝術體驗，透過填色的方式，讓你發揮創意，同時享受著色的樂趣，是一個放鬆身心且充滿創造力的娛樂方式。",
                          borderColor: mainOfColor,
                          gameURL: "https://i-gamer.net/play/16178.html"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      GameBox(
                          gameName: "幸運娃娃",
                          gameIntroduce: "來幫可愛的洋娃娃換上可愛的衣服吧!~~",
                          borderColor: mainOfColor,
                          gameURL: "https://www.babygames.com/Lucky-Doll"
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      GameBox(
                          gameName: "找找我在哪",
                          gameIntroduce: "《找找我在哪》是一款畫面簡單但讓人超上癮的休閒類遊戲。玩家在遊戲中，需要從茫茫人海當中，找出最與眾不同的那位小人！",
                          borderColor: mainOfColor,
                          gameURL: "https://www.i-gamer.net/play/21002.html"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      GameBox(
                          gameName: "喵喵愛之旅",
                          gameIntroduce: "超有趣的《喵喵愛之旅》是一款點擊益智遊戲，玩家需要在其中化身貓咪邱比特，幫助這隻陷入愛河的黑貓，穿梭一個個房間，找到被奶奶藏起來的阿娜答。",
                          borderColor: mainOfColor,
                          gameURL: "https://www.i-gamer.net/play/20565.html"),
                    ],
                  ),
      ),
    );
  }
}