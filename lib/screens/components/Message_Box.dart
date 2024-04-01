import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';

//設定衛教資料的訊息格子
class MessageBox extends StatelessWidget{
  const MessageBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.stringColor,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Color stringColor;
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15), vertical: getProportionateScreenHeight(2)),
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          side: BorderSide(color: Colors.white10, width: 5.0),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(35),vertical: getProportionateScreenHeight(15)),
            child: Column(
              children: [
                Text(title, //標題
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize:
                      getProportionateScreenWidth(72),
                      color: stringColor,
                      height: 1
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(subtitle, //子標題
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: getProportionateScreenWidth(56),
                      color: stringColor,
                      height: 1.1
                  ),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            )
        ),
      ),
    );
  }
}