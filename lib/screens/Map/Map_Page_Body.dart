import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//設定接種地圖的物件
class MapPageBody extends StatefulWidget{
  const MapPageBody({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;
  @override
  State<MapPageBody> createState() => _MapPageBodyState();
}

class _MapPageBodyState extends State<MapPageBody> {
  late final WebViewController controller; //設定網頁的控制器
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://antiflu.cdc.gov.tw/'), //設定內嵌的網址
      )..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context){
    return Flexible(
      fit: FlexFit.tight,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
