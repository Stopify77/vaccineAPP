import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import '../../constants.dart';
import 'Mom_Test.dart';


class MomLights extends StatelessWidget{
  const MomLights({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  @override
  Widget build(BuildContext context){
    return SubPage(
      colorStyle: mainOfColor,
      pageName: mainOfName,
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
      body:
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.025),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kColorStyle444, width: 3),
              borderRadius: BorderRadius.circular(20)
            ),
            // alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10), horizontal: getProportionateScreenWidth(20)),
              child: Text("你的壓力燈號",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(78),
                    color: mainOfColor,
                    fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03),
          Container(
            height: getProportionateScreenHeight(200),
            width: getProportionateScreenWidth(400),
            decoration: BoxDecoration(
              color: doneTest.value? lightColor(): Colors.black54,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 15)
            ),
          ),
          Center(
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: "壓力分數 : ", style: TextStyle(fontSize: getProportionateScreenWidth(50), color: kColorStyle444 )),
                      TextSpan(text: stressScore.value.toStringAsFixed(1), style: TextStyle(fontSize: getProportionateScreenWidth(64), color: kColorStyle444)),
                    ]
                ),
              )
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kColorStyle444, width: 3),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10), horizontal: getProportionateScreenWidth(15)),
                child:
                    RichText(
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.clip,
                      maxLines: 5,
                      text: TextSpan(
                          children: [
                            TextSpan(text: doneTest.value? textOfLight() : "尚未進行測驗，請前往測驗", style: TextStyle(color: kTextColor, fontSize: getProportionateScreenWidth(42))),
                          ]),
                    ),
              ),
            ),
          ),
              SizedBox(height: getProportionateScreenHeight(20),),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MomTest(
                            mainOfColor: mainOfColor,
                            mainOfName: "壓力測試",
                          )
                      )
                  );
                  doneTest.value = false;
                  stressScore.value = 0;
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainOfColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(40),
                          vertical: getProportionateScreenHeight(20)
                      ),
                      child: Text(
                        "前往/重新測驗",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(28),
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}

Color lightColor(){
  if(stressScore.value <= 3 && stressScore.value >=0){
    return Colors.green;
  }
  else if(stressScore.value > 3 && stressScore.value <= 5){
    return Colors.yellow;
  }
  else if(stressScore.value > 5){
    return Colors.redAccent;
  }
  else {
    return kColorStyle444;
  }
}

String textOfLight(){
  if(stressScore.value <= 3 && stressScore.value >=0){
    return "綠燈: 太好了! 你的壓力燈號為綠燈，繼續保持正向和樂觀的態度喔!";
  }
  else if(stressScore.value > 3 && stressScore.value <= 5){
    return "黃燈: 你的壓力燈號為黃燈，還在能負荷的範圍內，若是有疫苗相關的問題正困擾著你，記得適時尋求醫護人員的諮詢喔!";
  }
  else if(stressScore.value > 5){
    return "紅燈: 請注意!! 你的壓力燈號為紅燈，看來疫苗相關的問題正困擾著你，必須尋求醫護人員的諮詢及照護，不要猶豫喔!";
  }
  else {
    return "尚未進行測驗，請前往測驗";
  }
}