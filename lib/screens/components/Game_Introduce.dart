import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class GameBox extends StatelessWidget{
  const GameBox({
    Key? key,
    required this.gameName,
    required this.gameIntroduce,
    required this.borderColor,
    required this.gameURL,
  }) : super(key: key);

  final String gameName;
  final String gameIntroduce;
  final String gameURL;
  final Color borderColor;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  @override



  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: borderColor, width: 5)
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(25),
              vertical: getProportionateScreenHeight(10)
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gameName, style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.04,
                      color: kTextColor
                  ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.62,
                    decoration:  const BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey, width: 2))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
                      child: Text(gameIntroduce,
                        maxLines: 4,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: kTextColor),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.deepOrangeAccent,
                  ),
                  child: InkWell(
                    onTap: (){
                      final Uri url =Uri.parse(gameURL);
                      _launchUrl(url);
                    },
                    child: Center(
                        child: Text(
                          "點擊遊玩",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *0.021,
                              color: Colors.white
                          ),
                        )
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}