import 'package:flutter/material.dart';
import 'package:vaccine_app_project/size_config.dart';

class FunctioningCards extends StatelessWidget {
  const FunctioningCards({
    Key? key,
    required this.imageAssets,
    required this.press,
    required this.currentWidth,
  }) : super(key: key);

  final GestureTapCallback press;
  final String imageAssets;
  final double currentWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(6),
          vertical: getProportionateScreenHeight(2)),
      child: InkWell(
        onTap: press,
        child: SizedBox(
            width: currentWidth,
            child: Image.asset(
              imageAssets,
              fit: BoxFit.fitWidth,
            )),
      ),
    );
  }
}
