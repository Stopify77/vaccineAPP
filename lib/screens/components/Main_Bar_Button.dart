import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/size_config.dart';

//設定右上角按鈕的通用樣式
class MainBarButton extends StatelessWidget{
    const MainBarButton({
      Key? key,
      required this.svgSrc,
      required this.num,
      required this.press,
      required this.iconOfColor,
    }) : super(key: key);

    final String svgSrc;
    final int num;
    final GestureTapCallback press;
    final Color iconOfColor;

  @override
  Widget build(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(right: kDefaultPadding-8),
    child: InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        children: [
          Container(
            height: getProportionateScreenHeight(115),
            width: getProportionateScreenWidth(115),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape:BoxShape.circle,
            ),
            child: SvgPicture.asset(
              svgSrc,
              colorFilter: ColorFilter.mode(iconOfColor, BlendMode.srcIn),
            ),
          ),
          if(num != 0)
            Positioned(
                top: -3,
                right: 2,
                child: Container(
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(40),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape:BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "$num",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(28),
                          height:1,
                          fontWeight:FontWeight.bold,
                          color:Colors.white,
                      ),
                    ),
                  ),
                )
            )
        ],
      ),
    ),
  );
  }
}