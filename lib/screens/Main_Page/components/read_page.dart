import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Main_Page/message_page.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../constants.dart';

//設定閱讀的頁面 網頁的瀏覽以及影片的觀看
class readPage extends StatefulWidget{
  const readPage({super.key, required this.readWeb, required this.whichCase});
  final String readWeb; //內容物的Url
  final int whichCase; //判斷為哪種內容物 (1=文章，2=影片，3=海報)

  @override
  State<readPage> createState() => _readPageState();
}

class _readPageState extends State<readPage> {
  //設定Controller的設定 controller 為文章及海報的控制器 _controller 為影片的控制器
  late final WebViewController controller;
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.whichCase == 1 || widget.whichCase == 3) { //當內容物為文章或海報的時候 (1=文章，3=海報)
      controller = WebViewController()
        ..loadRequest(
          Uri.parse(widget.readWeb),
        )..setJavaScriptMode(JavaScriptMode.unrestricted);
    }else if (widget.whichCase == 2){ //當內容物為影片的時候
      var videoID = YoutubePlayer.convertUrlToId(widget.readWeb);
       _controller = YoutubePlayerController(
          initialVideoId: videoID.toString(),
          flags: const YoutubePlayerFlags(
            controlsVisibleAtStart: true,
            mute: false,
            autoPlay: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          )
      );
    }
  }

  // 顯示物件
  @override
  Widget build(BuildContext context){
    return _showBody();
  }

  Widget _showBody(){
    if (widget.whichCase == 1 || widget.whichCase == 3) { //當內容物為文章或海報的時候 (1=文章，3=海報)
      return DefaultPage(
          body:  Flexible(
              child: WebViewWidget(controller: controller)
          ),
          iconOfColor: kTextColor,
          backGroundImage: 'assets/images/MainPage.png',
          press: (){ //返回鍵 返回到全部消息的頁面
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const MessagePage()));
         },
      );

    }
    else if (widget.whichCase == 2){ //當內容物為影片的時候
      return YoutubePlayerBuilder(
          player: YoutubePlayer(
          controller: _controller,
            aspectRatio: 16/9,
          ),
          builder: (context, player){
              return
                  DefaultPage(
                    body: player,
                    iconOfColor: kTextColor,
                    backGroundImage: 'assets/images/MainPage.png',
                    press: (){ //返回鍵 返回到全部消息的頁面
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const MessagePage()));
                    },
                  );
          }
    );
    }else{
      return Container();
    }
  }
  @override
  void dispose() {
    if (widget.whichCase == 2){
      _controller.dispose(); //影片的controller的dispose
    }
    super.dispose();
  }
}

