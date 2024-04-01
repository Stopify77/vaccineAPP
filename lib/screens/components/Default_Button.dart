import 'package:flutter/material.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'package:vaccine_app_project/constants.dart';

//設定預設的按鈕 使用到按鈕時從這邊呼叫即可 讓整體APP的按鈕統一格式
class DefaultButton extends StatelessWidget{
  const DefaultButton({
    Key? key,
    required this.mainOfColor,
    required this.nameOfButton,
    required this.press,
    required this.buttonOfHeight,
  }) : super(key: key);

  final Color mainOfColor;
  final String nameOfButton;
  final double buttonOfHeight;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.0125),
      child: SizedBox(
        width: double.infinity,
        height: buttonOfHeight,
        child: TextButton(
          onPressed: press,
          style: TextButton.styleFrom(
              backgroundColor: mainOfColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)
              )
          ),
          child: Text("$nameOfButton",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(65),
                color: kPrimaryColor,
                height: 1.2
            ),
          ),
        ),
      ),
    );
  }
}