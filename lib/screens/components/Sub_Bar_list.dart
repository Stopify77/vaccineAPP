import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'Icon_Button.dart';

//子畫面在左上角需要有頁面名稱
class SubBarList extends StatelessWidget{
  const SubBarList({
    Key? key,
    required this.iconOfColor,
    required this.pageName,
    required this.colorStyle,

  }) : super(key: key);

  final Color iconOfColor;
  final String pageName;
  final Color colorStyle;


  @override
  Widget build(BuildContext context) {
    double fontOfSize=0;
    switch(pageName.length){ //設定不同子頁面的名稱大小
      case 3:
        fontOfSize=getProportionateScreenWidth(70);
      case 4:
        fontOfSize=getProportionateScreenWidth(70);
      case 5:
        fontOfSize=getProportionateScreenWidth(65);
      case 6:
        fontOfSize=getProportionateScreenWidth(55);
      case 7:
        fontOfSize=getProportionateScreenWidth(45);
      case 8:
        fontOfSize=getProportionateScreenWidth(40);
      case 9:
        fontOfSize=getProportionateScreenWidth(40);
      case 11:
        fontOfSize=getProportionateScreenWidth(35);
      case 12:
        fontOfSize=getProportionateScreenWidth(30);
      case 13:
        fontOfSize=getProportionateScreenWidth(30);
      case 14:
        fontOfSize=getProportionateScreenWidth(28);
      case 15:
        fontOfSize=MediaQuery.of(context).size.height*0.02;
      case 20:
        fontOfSize=MediaQuery.of(context).size.height*0.022;
      case 21:
        fontOfSize=getProportionateScreenWidth(30);
      case 24:
        fontOfSize=getProportionateScreenWidth(32);
      case 25:
        fontOfSize=getProportionateScreenWidth(32);
      case 26:
        fontOfSize=getProportionateScreenWidth(22);
      default:
        fontOfSize=getProportionateScreenWidth(75);
    }
    return SizedBox(
      height: getProportionateScreenHeight(60),
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(10),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateScreenHeight(10),left: getProportionateScreenWidth(15)),
              child: RichText(
                maxLines: 2,
                  text: TextSpan(
                      text: pageName,style: TextStyle(
                    fontSize: fontOfSize,
                    color: colorStyle,
                    fontWeight: FontWeight.w500,
                  )
                  )
              ),
            ),
            IconButtons(iconOfColor:iconOfColor)
          ],
        ),
      ),
    );
  }
}