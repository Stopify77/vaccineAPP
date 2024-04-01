import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vaccine_app_project/screens/components/Sub_Bar_list.dart';
import 'package:vaccine_app_project/size_config.dart';
import '../Report/Report_Page.dart';

//設定子頁面的樣式 相較通用頁面有更多自定義的設定
class PDFPage extends StatelessWidget{
  const PDFPage({
    Key? key,
    required this.body,
    required this.iconOfColor,
    required this.backGroundImage,
    required this.pageName,
    required this.colorStyle,
  }) : super(key: key);

  final Widget body;
  final Color iconOfColor;
  final String backGroundImage;
  final String pageName;
  final Color colorStyle;

  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        Stack(
          children: [
            Image.asset(
              backGroundImage,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
              Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(50),),
                  SubBarList(
                    pageName: pageName,
                    colorStyle: colorStyle,
                    iconOfColor: iconOfColor,
                  ),
                  body,
                  // SizedBox(height: MediaQuery.of(context).size.height*0.13,)
                ],
              ),
          ],
        ),
        floatingActionButton: _returnButton(context, iconOfColor)
    );
  }
}

Widget _returnButton(context, iconOfColor){ //返回按鈕的物件
  if(ModalRoute.of(context)?.settings.name != '/MainPage'){ //判斷當前頁面使否在首頁 如果不是就不顯示返回鍵
    return  Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      child: InkWell(
        onTap: (){
          if(ModalRoute.of(context)?.settings.name == "/ReportDay") {
            Navigator.pushReplacementNamed(context, ReportPage.routeName);
          } else{
            Navigator.pop(context);
          }
        },
        child: Container(
          width: getProportionateScreenWidth(150),
          height: getProportionateScreenHeight(100),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape:BoxShape.circle,
          ),
          child: SvgPicture.asset('assets/icons/back.svg',fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(iconOfColor, BlendMode.srcIn),),
        ),
      ),
    );
  }else {
    return Container();
  }
}

