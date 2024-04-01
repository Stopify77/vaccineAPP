import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import '../../constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportSurvey extends StatelessWidget{
  const ReportSurvey({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  //https://forms.gle/hTvoUUcBMxMF6krLA
  @override
  Widget build(BuildContext context){
    return SubPage(
      colorStyle: mainOfColor,
      pageName: mainOfName,
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
      body: Column(
        children:[
          SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
          Center(
            child: Text("*請注意，此問卷僅能填寫一次", style: TextStyle(color: Colors.redAccent, fontSize: getProportionateScreenHeight(24)),),),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50), vertical: getProportionateScreenHeight(20)),
              child: InkWell(
                onTap: (){
                  if(accountName.value != "0000"){
                  final Uri url =
                      Uri.parse("https://forms.gle/hTvoUUcBMxMF6krLA");
                  _launchUrl(url);
                }
              },
                child: Container(
                  height:MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: buttonColor(),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5),horizontal: getProportionateScreenWidth(15)),
                      child: Center(child: Text("填寫接種反應調查問卷",
                        style: TextStyle(fontSize: getProportionateScreenHeight(35), color: kPrimaryColor),
                        textAlign: TextAlign.justify,
                      )
                      )
                  ),
                ),
              )),
        ]
      ),
    );
  }
}

Color buttonColor() {
  if (accountName.value == "0000"){
    return Colors.grey;
  }else{
    return kColorStyle222;
  }
}