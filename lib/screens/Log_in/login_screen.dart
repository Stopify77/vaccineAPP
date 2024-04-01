import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:http/http.dart' as http;
import '../../size_config.dart';
import 'components/Login_Form.dart';

//設定登入畫面的地方
class LoginScreen extends StatefulWidget{
  static String routeName = "/LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final doMainController = TextEditingController();

  //目前線上人數
  _onlineCOUNT() async {
    var res = await http.get(
      Uri.parse('${VMURL}onlineCOUNT.php'),
    );
    Map<String, dynamic> data = json.decode(res.body);
    String countValue = data["COUNT(*)"].toString();

    setState(() {
      onlineCount.value = countValue;
    });
  }
  //點閱率
  _ctr() async {
    var res = await http.get(
      Uri.parse('${VMURL}countpeople.php'),
    );
    Map<String, dynamic> data = json.decode(res.body);
    String countValue = data["count"].toString();
    setState(() {
      clickedCount.value = countValue;
    });
  }
  void loadServerDomain()async{
    final prefs = await SharedPreferences.getInstance();
    String? serverDomain = prefs.getString('ServerDomain');
    if (serverDomain!.isNotEmpty){
      setState(() {
        doMain.value = serverDomain;
      });
      print("讀取到已儲存的網域: ${doMain.value}");
    }else{
      print("無紀錄的網域");
    }
  }

  @override
  void initState() {
    super.initState();
    _onlineCOUNT();
    _ctr();
  }

  @override
  void dispose(){
    super.dispose();
    doMainController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
       body: Stack(
         children: [
           Image.asset(
             "assets/images/background.png",
             fit: BoxFit.fill,
             height: double.infinity,
             width: double.infinity,
           ),
           SafeArea(
             child: SizedBox(
               width: double.infinity,
               height: double.infinity,
               child:
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
                 child:
                 SingleChildScrollView(
                   physics: const BouncingScrollPhysics(),
                   child: Column(
                       children: [
                         SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                         Text("流感疫苗資訊app",
                           style: TextStyle(
                             fontSize: getProportionateScreenWidth(48),
                             color: kThirdColor,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                         Text("孕媽咪健康寶典",
                           style: TextStyle(
                             fontSize: getProportionateScreenWidth(80),
                             color: kSecondaryColor,
                             fontWeight: FontWeight.bold,
                             height: 1.2,
                             textBaseline: TextBaseline.ideographic,
                           ),
                           textAlign: TextAlign.center,
                         ),
                         Image.asset( //媽咪的圖片
                           "assets/images/loginImage.png",fit: BoxFit.cover,height: getProportionateScreenHeight(350),),
                         Padding( //登入的帳號密碼以及登入按鈕
                             padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(80)),
                             child: const LoginForm() //帳號密碼登入介面 包含登入按鈕lib/screens/Log_in/components
                         ),
                         Padding( //點閱率跟線上人數顯示
                           padding: EdgeInsets.only(top: getProportionateScreenHeight(8)),
                           child: RichText(
                               text: TextSpan(
                                   text: "點閱率 ${clickedCount.value} / 目前線上人數 ${onlineCount.value}",
                                   style: TextStyle(color: Colors.grey, fontSize: getProportionateScreenWidth(32)
                                   )
                               )
                              ),
                         ),
                       ],
                     ),
                 ),
               ),
             ),
           ),
         ],
       ),
     );
  }
}
