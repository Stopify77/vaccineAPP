import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Icon_Button.dart';
import 'package:vaccine_app_project/size_config.dart';

//提供通用頁面使用的右上角的物件
class MainBarList extends StatelessWidget{
  const MainBarList({
    Key? key,
    required this.iconOfColor,
  }) : super(key: key);

  final Color iconOfColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(60),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10),),
        child: IconButtons(iconOfColor:iconOfColor)
      ),
    );
  }
}