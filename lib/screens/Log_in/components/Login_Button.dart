import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/size_config.dart';

class LoginButton extends StatelessWidget{
  const LoginButton({
    Key? key,
    required this.press,
  }) : super(key: key);

  final GestureTapCallback press;
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(15), bottom: getProportionateScreenHeight(5)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(75)),
        onTap: press,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(75)),
            color: kSecondaryColor,
          ),
          width: getProportionateScreenWidth(520),
          height: getProportionateScreenHeight(50),
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
                text: "登   入",
                style: TextStyle(color: kPrimaryColor, fontSize: getProportionateScreenWidth(52))
            ),
          ),
        ),
      ),
    );
  }
}