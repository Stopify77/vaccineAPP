import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vaccine_app_project/screens/components/Main_bar_list.dart';
import 'package:vaccine_app_project/size_config.dart';

//設定通用頁面
class DefaultPage extends StatelessWidget{
  const DefaultPage({
    Key? key,
    required this.body,
    required this.iconOfColor,
    required this.backGroundImage,
    required this.press,
  }) : super(key: key);

  final Widget body;
  final Color iconOfColor;
  final String backGroundImage;
  final GestureTapCallback press;

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
                    MainBarList(
                      iconOfColor: iconOfColor,
                    ),
                    body,
                  ],
                ),
            ],
          ),
      floatingActionButton: _returnButton(context, iconOfColor, press)
    );
  }
}

Widget _returnButton(context, iconOfColor, press){ //返回按鈕的物件
  if(ModalRoute.of(context)?.settings.name != '/MainPage'){ //判斷當前頁面使否在首頁 如果不是就不顯示返回鍵
    return  Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
      ),
      child: InkWell(
        onTap:
          press,
        child: Container(
          width: getProportionateScreenWidth(150),
          height: getProportionateScreenHeight(80),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape:BoxShape.circle,
          ),
          child: SvgPicture.asset('assets/icons/back.svg',fit: BoxFit.contain,alignment: Alignment.centerLeft,
          colorFilter: ColorFilter.mode(iconOfColor, BlendMode.srcIn),),
        ),
      ),
    );
  }else {
    return Container();
  }
}

