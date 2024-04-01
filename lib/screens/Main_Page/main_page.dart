import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Main_Page/components/read_page.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';
import '../../size_config.dart';
import '../Mom/Mom_Test.dart';
import 'components/Function_List.dart';
import 'components/New_Message.dart';
import 'message_page.dart';

//設定首頁的畫面
class MainPage extends StatefulWidget {
  static String routeName = "/MainPage"; //設定首頁的路由名稱

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  List<Map<String, dynamic>> dataList = []; //未讀消息
  List<Map<String, dynamic>> dataList2 = []; //已讀消息

  //計算未讀消息數
  _countMessage() async {
    if (accountName.value == "0000") {
      setState(() {
        messageCount.value = 0;
      });
    }
    //獲得創建日期
    if (accountName.value != "0000") {
      var res0 = await http.post(
        Uri.parse('${VMURL}read_numbers.php'),
        body: {
          'name': accountName.value,
        },
      );
      List<dynamic> data0 = json.decode(res0.body);
      String readNumbers =
          data0.map((item) => item['news_number'].toString()).join(', ');
      var res = await http.post(
        Uri.parse('${VMURL}creationDate.php'),
        body: {
          'name': accountName.value,
        },
      );
      Map<String, dynamic> data = json.decode(res.body);
      //計算消息數
      var res2 = await http.post(
        Uri.parse('${VMURL}countMessage_NKUST.php'),
        body: {
          'name': accountName.value,
          'date': data["date"],
          'readNumbers': readNumbers,
        },
      );
      Map<String, dynamic> data2 = json.decode(res2.body);
      setState(() {
        if (data2['result'] == "0") {
          messageCount.value = 0;
        } else {
          messageCount.value = int.tryParse(data2['result'])!;
        }
      });
    }
  }

  //載入五條消息
  loadData() async {
    dataList = [];
    dataList2 = [];
      var res0 = await http.post(
        Uri.parse('${VMURL}read_numbers.php'),
        body: {
          'name': accountName.value,
        },
      );
      List<dynamic> data0 = json.decode(res0.body);
      String readNumbers =
          data0.map((item) => item['news_number'].toString()).join(', ');

      //未讀消息
      var res1 = await http.post(
        Uri.parse('${VMURL}totalNews2_NKUST.php'),
        body: {
          'name': accountName.value,
          'readNumbers': readNumbers,
        },
      );
      final jsonData = json.decode(res1.body);
      dataList = jsonData.cast<Map<String, dynamic>>();
      //以讀消息
      var res2 = await http.post(
        Uri.parse('${VMURL}news2_NKUST.php'),
        body: {
          'name': accountName.value,
          'limit': (5 - dataList.length).toString(),
          'readNumbers': readNumbers,
        },
      );
      final jsonData2 = json.decode(res2.body);
      dataList2 = jsonData2.cast<Map<String, dynamic>>();
    setState(() {
      dataList;
      dataList2;
    });
  }

  //更改是否觀看
  change_setting(number) async {
    if (accountName.value != "0000") {
      await http.post(
        Uri.parse('${VMURL}change_setting.php'),
        body: {'name': accountName.value, 'number': number},
      );
    }
  }

  TestRemind() async {
    if (accountName.value != "0000") {
      var res = await http.post(
        Uri.parse('${VMURL}creationDate.php'),
        body: {
          'name': accountName.value,
        },
      );
      Map<String, dynamic> data = json.decode(res.body);
      DateTime creationDate = DateTime.parse(data["date"]);
      DateTime dateTimeNow = DateTime.now();
      DateTime oneMonthLater = creationDate.add(const Duration(days: 30));
      DateTime twoMonthLater = creationDate.add(const Duration(days: 60));
      if ((dateTimeNow.isAfter(dateTimeNow) ||
              dateTimeNow.isAtSameMomentAs(dateTimeNow)) &&
          dateTimeNow.isBefore(oneMonthLater)) {
        testNumber.value = "first_test";
        var res2 = await http.post(
          Uri.parse('${VMURL}checkTest.php'),
          body: {
            'name': accountName.value,
            'number': "first_test",
          },
        );
        Map<String, dynamic> data2 = json.decode(res2.body);
        if (data2["first_test"] == null) {
          needTest.value = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('通知'),
                content: Text('請協助完成第一次壓力測試調查'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MomTest(
                                    mainOfColor: kColorStyle222,
                                    mainOfName: "壓力測試",
                                  )));
                    },
                    child: Text('確定'),
                  ),
                ],
              );
            },
          );
        }
      }
      if ((dateTimeNow.isAfter(oneMonthLater) ||
              dateTimeNow.isAtSameMomentAs(oneMonthLater)) &&
          dateTimeNow.isBefore(twoMonthLater)) {
        testNumber.value = "second_test";
        var res2 = await http.post(
          Uri.parse('${VMURL}checkTest.php'),
          body: {
            'name': accountName.value,
            'number': "second_test",
          },
        );
        Map<String, dynamic> data2 = json.decode(res2.body);
        if (data2["second_test"] == null) {
          needTest.value = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('通知'),
                content: Text('請協助完成第二次壓力測試調查'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MomTest(
                                    mainOfColor: kColorStyle222,
                                    mainOfName: "壓力測試",
                                  )));
                    },
                    child: Text('確定'),
                  ),
                ],
              );
            },
          );
        }
      }
      if ((dateTimeNow.isAfter(twoMonthLater) ||
          dateTimeNow.isAtSameMomentAs(twoMonthLater))) {
        testNumber.value = "third_test";
        var res2 = await http.post(
          Uri.parse('${VMURL}checkTest.php'),
          body: {
            'name': accountName.value,
            'number': "third_test",
          },
        );
        Map<String, dynamic> data2 = json.decode(res2.body);
        if (data2["third_test"] == null) {
          needTest.value = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('通知'),
                content: Text('請協助完成第三次壓力測試調查'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MomTest(
                                    mainOfColor: kColorStyle222,
                                    mainOfName: "壓力測試",
                                  )));
                    },
                    child: Text('確定'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  //消息點閱率
  news_ctr(number) async {
    await http.post(
      Uri.parse('${VMURL}newsCTR_NKUST.php'),
      body: {'number': number},
    );
  }

  Future<void> _refresh() async {
    loadData();
    loadEventData();
    _countMessage();
    return Future.delayed(const Duration(seconds: 1));
  }

  //讀取資料庫資料
  Future<Map<String, int>> loadEventData() async {
    final prefs = await SharedPreferences.getInstance();

    String? currentEventEncoded = prefs.getString('currentEvent');
    DateTime? nextEventDate;
    int addReportEvent = 0;

    // 如果存在 currentEvent 數據，則解析並計算距離下一個事件的天數
    if (currentEventEncoded != null) {
      Map<String, dynamic> currentEventData = jsonDecode(currentEventEncoded);
      nextEventDate = DateTime.parse(currentEventData['eventDate']);
      addReportEvent = 1;
    }

    int daysUntilNextEvent = nextEventDate != null
        ? DateTime.now().difference(nextEventDate).inDays.abs()
        : 0;
    if (daysUntilNextEvent == 0) {
      addReportEvent = 0;
    }

    // 從 SharedPreferences 加載 'myEvents' 數據
    String? encodedData = prefs.getString('myEvents');
    Map<DateTime, List<dynamic>> mySelectedEvents = {};
    if (encodedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(encodedData);
      mySelectedEvents = decodedData.map(
        (key, value) => MapEntry(
          DateTime.parse(key),
          value,
        ),
      );
    }
    int totalEvents = mySelectedEvents.keys
        .where((data) => data.isAfter(DateTime.now()))
        .length;
    setState(() {
      calendarEventCount.value = totalEvents + addReportEvent;
      vaccineDeadline.value = daysUntilNextEvent;
    });
// 返回包含剩餘天數和事件總數的 Map
    return {
      "totalEvents": totalEvents, //事件總數
    };
  }

  //傳入資料庫資料
  @override
  void initState() {
    super.initState();
    // 添加WidgetsBindingObserver
    WidgetsBinding.instance.addObserver(this);
    loadData();
    _countMessage();
    loadEventData();
    TestRemind();
  }

  //APP監控
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      await http.post(
        Uri.parse('${VMURL}onlineDELETE.php'),
        body: {
          'name': accountName.value,
        },
      );
      print("APP paused");
    } else if (state == AppLifecycleState.resumed) {
      await http.post(
        Uri.parse('${VMURL}onlineADD.php'),
        body: {
          'name': accountName.value,
        },
      );
      print("APP resumed");
    }
  }

  @override
  void dispose() async {
    // 移除WidgetsBindingObserver
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int caseSituation = 0;
    return WillPopScope(
      onWillPop: () async {
        setState(() async {
          await http.post(
            Uri.parse('${VMURL}onlineDELETE.php'),
            body: {
              'name': accountName.value,
            },
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', '');
          accountName.value = '';
          accountPassword.value = '';
          Navigator.pushNamedAndRemoveUntil(
              context, '/LoginScreen', (Route<dynamic> route) => false);
        });
        return false;
      },
      child: DefaultPage(
        body: Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45), topLeft: Radius.circular(45)),
              color: kPrimaryColor,
            ),
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(35),
                  right: getProportionateScreenWidth(35),
                  top: getProportionateScreenHeight(35)),
              child: RefreshIndicator(
                //上滑更新資料的功能
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(15)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "最新消息",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      color: kTextColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                ListView.builder(
                                    //最新消息的五則訊息顯示
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(3)),
                                    shrinkWrap: true,
                                    itemCount:
                                        dataList.length + dataList2.length,
                                    itemBuilder: (context, index) {
                                      if (index < dataList.length) {
                                        // final Uri _url = Uri.parse(dataList[index]['url']);
                                        return NewMessage(
                                            label: dataList[index]['label'] ??
                                                "label",
                                            //顯示標籤
                                            message: dataList[index]['title'],
                                            //顯示訊息
                                            whatColor: Colors.blue,
                                            //將文字改為藍色(未讀樣式)
                                            press: () async {
                                              if (dataList[index]['type'] ==
                                                  "article") {
                                                //判斷內容物為哪種
                                                caseSituation = 1; //文章
                                              } else if (dataList[index]
                                                          ["type"] ==
                                                      "video-1" ||
                                                  dataList[index]["type"] ==
                                                      "video-2") {
                                                caseSituation = 2; //影片
                                              } else if (dataList[index]
                                                          ["type"] ==
                                                      "poster-1" ||
                                                  dataList[index]["type"] ==
                                                      "poster-2" ||
                                                  dataList[index]["type"] ==
                                                      "poster-3") {
                                                caseSituation = 3; //海報
                                              }
                                              Navigator.push(
                                                  //將頁面切換到readPage
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          readPage(
                                                            readWeb:
                                                                dataList[index]
                                                                    ['url'],
                                                            //將內容物的 Url 傳到readPage
                                                            whichCase:
                                                                caseSituation, //將內容物的 種類 傳到readPage
                                                          )));
                                              await change_setting(
                                                  dataList[index]
                                                      ['number']); //更新閱讀狀態 改為已讀
                                              await news_ctr(dataList[index]
                                                  ['number']); //將文章的點閱率+1
                                              await _countMessage(); //更新未讀消息數
                                              await loadData(); //讀取新的資料
                                              // print("done");
                                            });
                                      } else if (index <
                                          dataList.length + dataList2.length) {
                                        // final Uri _url = Uri.parse(dataList2[(index - dataList.length)]['url']);
                                        return NewMessage(
                                            label: dataList2[(index -
                                                        dataList.length)]
                                                    ['label'] ??
                                                "label",
                                            //顯示標籤
                                            message: dataList2[(index -
                                                dataList.length)]['title'],
                                            //顯示訊息
                                            whatColor: kTextColor,
                                            //將文字改為灰色(已讀樣式)
                                            press: () async {
                                              if (dataList2[(index - dataList.length)]
                                                      ['type'] ==
                                                  "article") {
                                                //判斷內容物為哪種
                                                caseSituation = 1; //文章
                                              } else if (dataList2[(index - dataList.length)]
                                                          ["type"] ==
                                                      "video-1" ||
                                                  dataList2[(index - dataList.length)]
                                                          ["type"] ==
                                                      "video-2") {
                                                caseSituation = 2; //影片
                                              } else if (dataList2[(index -
                                                              dataList.length)]
                                                          ["type"] ==
                                                      "poster-1" ||
                                                  dataList2[(index - dataList.length)]
                                                          ["type"] ==
                                                      "poster-2" ||
                                                  dataList2[(index - dataList.length)]
                                                          ["type"] ==
                                                      "poster-3") {
                                                caseSituation = 3; //海報
                                              }
                                              Navigator.push(
                                                  //將頁面切換到readPage
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) => readPage(
                                                                readWeb: dataList2[
                                                                        (index -
                                                                            dataList.length)]
                                                                    ['url'],
                                                                //將內容物的 Url 傳到readPage
                                                                whichCase:
                                                                    caseSituation, //將內容物的 種類 傳到readPage
                                                              )));
                                              await news_ctr(dataList2[
                                                      (index - dataList.length)]
                                                  ['number']); //將文章的點閱率+1
                                              // print("done");
                                            });
                                      }
                                      return null;
                                    }),
                                Padding(
                                  //more...的按鈕 可以移動到全部消息的頁面
                                  padding: EdgeInsets.only(
                                      right: getProportionateScreenWidth(20)),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: RichText(
                                        textAlign: TextAlign.end,
                                        text: TextSpan(
                                            text: "more...",
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      36),
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 1.5,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                //將頁面切換到全部消息的頁面
                                                Navigator.pushNamed(context, MessagePage.routeName);
                                              })),
                                  ),
                                )
                              ])),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        //設定七大區塊的方塊
                        double width = constraints.maxWidth / 2 -
                            getProportionateScreenWidth(12);
                        return FunctionList(
                            currentWidth:
                                width); //呼叫lib/screens/Main_Page/components裡面的Function_List物件
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        iconOfColor: kPrimaryColor,
        backGroundImage: 'assets/images/MainPage.png',
        press: () {
          Navigator.pushReplacementNamed(context, "/MainPage");
        },
      ),
    );
  }
}
