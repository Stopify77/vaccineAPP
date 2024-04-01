import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class RelaxPost extends StatelessWidget{
  const RelaxPost({
    Key? key,
    required this.posterName,
    required this.posterIntroduce,
    required this.borderColor,
    required this.posterURL,
  }) : super(key: key);

  final String posterName;
  final String posterIntroduce;
  final String posterURL;
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
                  Text(posterName, style: TextStyle(
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
                      child: Text(posterIntroduce,
                        maxLines: 4,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: kTextColor),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
                child:
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.deepOrangeAccent,
                  ),
                  child: InkWell(
                    onTap: (){
                      final Uri url =Uri.parse(posterURL);
                      _launchUrl(url);
                    },
                    child: Center(
                        child: Text(
                          "點擊前往",
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