import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import '../../constants.dart';
import 'components/read_page.dart';

//設定所有消息的頁面
class MessagePage extends StatefulWidget{
  static String routeName = '/MessagePage'; //設定路由名稱

  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
      String readNumbers = data0.map((item) => item['news_number'].toString()).join(', ');

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
          'readNumbers' : readNumbers,
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

  //載入消息
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
    String readNumbers = data0.map((item) => item['news_number'].toString()).join(', ');

    //未讀消息
    var res1 = await http.post(
      Uri.parse('${VMURL}totalNews1_NKUST.php'),
      body: {
        'name': accountName.value,
        'readNumbers' : readNumbers,
      },
    );
    final jsonData = json.decode(res1.body);
    dataList = jsonData.cast<Map<String, dynamic>>();
    //已讀消息
    var res2 = await http.post(
      Uri.parse('${VMURL}totalNews3_NKUST.php'),
      body: {
        'name': accountName.value,
        'readNumbers' : readNumbers,
      },
    );
    final jsonData2 = json.decode(res2.body);
    dataList2 = jsonData2.cast<Map<String, dynamic>>();
    setState(() {
      dataList;
      dataList2;
    });
  }

  //改變是否觀看
  change_setting(number) async {
    if(accountName.value!="0000"){
    await http.post(
      Uri.parse('${VMURL}change_setting.php'),
      body: {'name': accountName.value, 'number': number},
    );
    }
  }

  //消息點閱率
  news_ctr(number) async {
    await http.post(
      Uri.parse('${VMURL}newsCTR_NKUST.php'),
      body: {'number': number},
    );
  }

  void loadAccount() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedUsername = prefs.getString('username');
      String? userPassword = prefs.getString('password');
      accountName.value = savedUsername!;
      accountPassword.value = userPassword!;
  }

  @override
  initState() {
    super.initState();
    if (accountName.value != "0000"){
      loadAccount();
    }
    loadData();
  }


  @override
  Widget build(BuildContext context){
    int caseSituation=0;
    return DefaultPage(
        body:
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                shrinkWrap: true,
                itemCount: dataList.length + dataList2.length,
                itemBuilder: (context, index) {
                if (index < dataList.length) { //未讀消息
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (dataList[index]['type'] == "article"){ //判斷內容物為哪種
                          caseSituation = 1; //文章
                        }else if (dataList[index]["type"] == "video-1" || dataList[index]["type"] == "video-2"){
                          caseSituation = 2; //影片
                        }else if (dataList[index]["type"] == "poster-1" || dataList[index]["type"] == "poster-2" || dataList[index]["type"] == "poster-3"){
                          caseSituation = 3; //海報
                        }
                        Navigator.push( //將頁面切換到readPage
                            context,
                            MaterialPageRoute(
                                builder: (context) => readPage(
                                  readWeb: dataList[index]['url'], //將內容物的 Url 傳到readPage
                                  whichCase: caseSituation, //將內容物的 種類 傳到readPage
                                )));
                        await change_setting(dataList[index]['number']); //更新閱讀狀態 改為已讀
                        await news_ctr(dataList[index]['number']); //將文章的點閱率+1
                        await _countMessage(); //更新未讀消息數
                        await loadData(); //讀取新的資料
                      },
                      child: Card( //消息的方塊
                        color: Colors.grey[100],
                        child: Column(
                          children: [
                            Padding( //標籤
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(dataList[index]['label'] ?? "label",
                                style: TextStyle(color: Colors.blue, fontSize: getProportionateScreenHeight(24)),
                              ),
                            ),
                            Padding( //標題
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                              child:Text(dataList[index]['title'],
                                style: TextStyle(color: Colors.blue, fontSize: getProportionateScreenHeight(24)),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Padding( //日期
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(dataList[index]['date'],
                                  style: TextStyle(color: Colors.blue, fontSize: getProportionateScreenHeight(24)),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }else { //已讀消息
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              if (dataList2[(index - dataList.length)]['type'] == "article"){ //判斷內容物為哪種
                                caseSituation = 1; //文章
                              }else if (dataList2[(index - dataList.length)]["type"] == "video-1" || dataList2[(index - dataList.length)]["type"] == "video-2"){
                                caseSituation = 2; //影片
                              }else if (dataList2[(index - dataList.length)]["type"] == "poster-1" || dataList2[(index - dataList.length)]["type"] == "poster-2" || dataList2[(index - dataList.length)]["type"] == "poster-3"){
                                caseSituation = 3; //海報
                              }
                              Navigator.push( //將頁面切換到readPage
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => readPage(
                                        readWeb: dataList2[(index - dataList.length)]['url'], //將內容物的 Url 傳到readPage
                                        whichCase: caseSituation, //將內容物的 種類 傳到readPage
                                      )));
                              await news_ctr(dataList2[(index - dataList.length)]['number']); //將文章的點閱率+1
                            },
                            child: Card( //消息的方塊
                              color: Colors.grey[100],
                              child: Column(
                                children: [
                                  Padding( //標籤
                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Text(dataList2[(index - dataList.length)]['label'] ?? "label",
                                        style: TextStyle(color: kTextColor, fontSize: getProportionateScreenHeight(24))),
                                  ),
                                  Padding( //標題
                                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                                    child: Text(dataList2[(index - dataList.length)]['title'],
                                        style: TextStyle(
                                            color: kTextColor, fontSize: getProportionateScreenHeight(24)),
                                        textAlign: TextAlign.justify,
                                      ),
                                  ),
                                  Padding( //日期
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: Text(dataList2[(index - dataList.length)]['date'],
                                        style: TextStyle(color: kTextColor, fontSize: getProportionateScreenHeight(24))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }
                ),
        ),
        iconOfColor: kTextColor,
        backGroundImage: 'assets/images/MainPage.png',
        press: (){
          Navigator.pushNamedAndRemoveUntil(context, "/MainPage", (Route<dynamic> route) => false);
        }
        );
  }
}