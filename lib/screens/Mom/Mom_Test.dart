import 'package:another_xlider/enums/tooltip_direction_enum.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/hatch_mark.dart';
import 'package:another_xlider/models/hatch_mark_label.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_box.dart';
import 'package:another_xlider/models/tooltip/tooltip_position_offset.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Mom/Mom_Lights.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'package:http/http.dart' as http;

class MomTest extends StatefulWidget{
  const MomTest({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  @override
  State<MomTest> createState() => _MomTestState();
}

class _MomTestState extends State<MomTest> {
  double _currentSliderValue = 0;

  @override
  void initState(){
    super.initState();
    setState(() {
      doneTest.value = false;
      stressScore.value = 0;
      _currentSliderValue = 0;
    });

  }

  @override
  Widget build(BuildContext context){
    return SubPage(
      colorStyle: widget.mainOfColor,
      pageName: widget.mainOfName,
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
      body:
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10), horizontal: getProportionateScreenWidth(20)),
            child: const Text(
              '       請您以滑塊方式選出目前壓力感受，0分表示無感覺壓力，10分表示壓力極大(分數越高代表壓力越大)。',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold, // 粗
                color: kColorStyle444,
                height: 1.35,
              ),
            ),
          ),
              SizedBox(width: getProportionateScreenWidth(150),),
                  Center(
                    child: SizedBox(
                        height: getProportionateScreenHeight(350), // 設定容器的高度
                        child: FlutterSlider(
                          axis: Axis.vertical, // 垂直方向
                          values: [10 - _currentSliderValue],
                          max: 10,
                          min: 0,
                          step: const FlutterSliderStep(step: 0.1),
                          jump: true,
                          rtl: false,
                          handler: FlutterSliderHandler(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 5, color: Colors.blue)
                              ),
                            child: Container(
                            )
                          ),
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            setState(() {
                              _currentSliderValue = 10.0 - lowerValue; // 更新滑塊的當前值
                            });
                          },
                          tooltip: FlutterSliderTooltip(
                            disabled: true,
                            textStyle: TextStyle(fontSize: getProportionateScreenHeight(24), color: Colors.white),
                            boxStyle: FlutterSliderTooltipBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: widget.mainOfColor,
                              )
                            ),
                            direction: FlutterSliderTooltipDirection.right,
                            positionOffset: FlutterSliderTooltipPositionOffset(
                                right: 170,
                            ),
                            format: (value) => _currentSliderValue.toStringAsFixed(1), //顯示透明
                          ),
                          trackBar: const FlutterSliderTrackBar(
                            activeTrackBar: BoxDecoration(
                              color: Colors.transparent,
                            )
                          ),
                          hatchMark: FlutterSliderHatchMark(
                            labelsDistanceFromTrackBar: getProportionateScreenWidth(360),
                            density: 0.1,
                            displayLines: true,
                            linesDistanceFromTrackBar: getProportionateScreenWidth(20),
                            labels: [
                              FlutterSliderHatchMarkLabel(percent: 100,
                                  label: Text("0分，無壓力", style: TextStyle(fontSize: getProportionateScreenWidth(38), color: kColorStyle444),)),
                              FlutterSliderHatchMarkLabel(percent: 0,
                                  label: Text("10分，壓力極大", style: TextStyle(fontSize: getProportionateScreenWidth(38), color: kColorStyle444),))
                            ]
                          ),
                        ),
                      ),
                  ),
          SizedBox(height: getProportionateScreenHeight(20),),
          Text(
            '壓力指數: ${_currentSliderValue.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(64),
              fontWeight: FontWeight.bold,
              color: widget.mainOfColor,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20),),
          InkWell(
            onTap: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MomLights(
                        mainOfColor: widget.mainOfColor,
                        mainOfName: "壓力燈號",
                      )
                  )
              );
              setState(() {
                stressScore.value = _currentSliderValue;
                doneTest.value = true;
              });
              if(needTest.value == true){
                await http.post(
                  Uri.parse('${VMURL}returnTest.php'),
                  body: {
                    'name': accountName.value,
                    'value': _currentSliderValue.toString(),
                    'number': testNumber.value,
                  },
                );
                setState(() {
                  needTest.value = false;
                });
              }
            },
            child: Container(
              width: getProportionateScreenWidth(300),
              height: getProportionateScreenHeight(55),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.mainOfColor,
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10),
                      horizontal: getProportionateScreenWidth(30)
                  ),
                  child: Text(
                    "確 定",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height*0.0325
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}