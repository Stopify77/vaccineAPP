import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_app_project/screens/components/Sub_Page.dart';
import 'package:vaccine_app_project/size_config.dart';
import '../../constants.dart';

class MyEvents {
  final DateTime eventDate;
  final String eventTitle;
  final String eventDescp;
  final TimeOfDay eventTime;

  MyEvents({
    required this.eventDate,
    required this.eventTitle,
    required this.eventDescp,
    required this.eventTime,
  });

  Map<String, dynamic> toJson() => {
    'eventDate': eventDate.toIso8601String(),
    'eventTitle': eventTitle,
    'eventDescp': eventDescp,
    'eventTime': {"hour": eventTime.hour, "minute": eventTime.minute},
  };

  static MyEvents fromJson(Map<String, dynamic> json) {
    return MyEvents(
      eventDate: DateTime.parse(json['eventDate']),
      eventTitle: json['eventTitle'],
      eventDescp: json['eventDescp'],
      eventTime: TimeOfDay(
          hour: json['eventTime']['hour'],
          minute: json['eventTime']['minute']
      ),
    );
  }
}

class ReportDay extends StatefulWidget{
  static String routeName = "/ReportDay";

  const ReportDay({
    Key? key,
    required this.mainOfColor,
    required this.mainOfName,
  }) : super(key: key);

  final Color mainOfColor;
  final String mainOfName;

  @override
  State<ReportDay> createState() => _ReportDayState();
}

class _ReportDayState extends State<ReportDay> {
  MyEvents? currentEvent;

  @override
  void initState() {
    super.initState();
    _loadEvent();
  }

  // 從 SharedPreferences 載入事件
  void _loadEvent() async {
    final prefs = await SharedPreferences.getInstance();
    String? eventJson = prefs.getString('currentEvent');
    if (eventJson != null) {
      setState(() {
        currentEvent = MyEvents.fromJson(jsonDecode(eventJson));

      });
    }
  }

  // 將事件儲存至 SharedPreferences
  void _saveEvent(MyEvents event) async {
    final prefs = await SharedPreferences.getInstance();
    String eventJson = jsonEncode(event.toJson());
    await prefs.setString('currentEvent', eventJson);
  }

  // 計算距離事件剩餘天數的函數
  int _calculateDaysRemaining(MyEvents event) {
    final now = DateTime.now();
    final difference = event.eventDate.difference(now).inDays;
    return difference;
  }

  // 添加或替換事件的函數
  void _addOrReplaceEvent(BuildContext context) async {
    final event = await showDialog<MyEvents>(
      context: context,
      builder: (context) => _EventInputDialog(),
    );

    if (event != null) {
      setState(() {
        if (currentEvent == null){
          calendarEventCount.value += 1;
        }
        currentEvent = event; // 更新當前事件
        _saveEvent(event); // 儲存事件
        vaccineDeadline.value = _calculateDaysRemaining(event);
      });
    }
  }

  void _deleteReportEvent() async {
    final prefs = await SharedPreferences.getInstance();
      // 如果刪除的是 currentEvent，則從 SharedPreferences 中清除
    await prefs.remove('currentEvent');
    setState(() {
      currentEvent = null;
      vaccineDeadline.value=0;
      calendarEventCount.value -= 1;
    });

  }


  @override
  Widget build(BuildContext context){
    return SubPage(
      colorStyle: widget.mainOfColor,
      pageName: widget.mainOfName,
      iconOfColor: kColorStyle444,
      backGroundImage: 'assets/images/back04.png',
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(90),),
          eventCreate(),
          SizedBox(height: getProportionateScreenHeight(90),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(10)),
                child: InkWell(
                  onTap: ()=> _addOrReplaceEvent(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.mainOfColor,
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(20),
                            horizontal: getProportionateScreenWidth(35)),
                        child: Text(
                            '添加/修改事件',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(72),
                                color: Colors.white
                            )
                        )
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }

  eventCreate() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kTextColor, width: 5)
        ),
          child: currentEvent == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
                  child: Text(
                    '沒有事件',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(72),
                      color: widget.mainOfColor
                    ),
                  )
              )
          ) // 如果沒有事件，顯示"沒有事件"
          : Padding(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
            child: ListTile(
                  title: Text(
                   currentEvent!.eventTitle,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(72),
                      height: 1.5
                    ), // 事件名稱
                 ),
                 subtitle: Padding(
                   padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                   child: Text(
                      '地點 : ${currentEvent!.eventDescp}\n時間 : \n${DateFormat.yMMMd().add_jm().format(currentEvent!.eventDate)}',
                     style: TextStyle(
                         fontSize: getProportionateScreenWidth(52),
                         height: 1.2,
                       color: widget.mainOfColor
                     ), // 地點
                   ),
                 ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  _deleteReportEvent();
                },
              ),
             ),
          )),
    );
  }
}

// 添加事件對話框的 StatefulWidget
class _EventInputDialog extends StatefulWidget {
  @override
  _EventInputDialogState createState() => _EventInputDialogState();
}

// 添加事件對話框的狀態類別
class _EventInputDialogState extends State<_EventInputDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('添加事件', style: TextStyle(fontSize: getProportionateScreenHeight(36)),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 事件名稱輸入框
          TextField(
            keyboardType: TextInputType.text,
            controller: nameController,
            decoration: const InputDecoration(labelText: '事件'),
          ),
          // 事件地點輸入框
          TextField(
            keyboardType: TextInputType.text,
            controller: locationController,
            decoration: const InputDecoration(labelText: '地點'),
          ),
          Row(
            children: [
              // 選擇日期按鈕
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text('選擇日期', style: TextStyle(fontSize: getProportionateScreenWidth(48)),),
              ),
              // 選擇時間按鈕
              TextButton(
                onPressed: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );

                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child:Text('選擇時間', style: TextStyle(fontSize: getProportionateScreenWidth(48)),),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // 取消按鈕
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消', style: TextStyle(fontSize: getProportionateScreenWidth(32)),),
        ),
        // 添加事件按鈕
        TextButton(
          onPressed: () {
            final name = nameController.text;
            final location = locationController.text;
            final dateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            final event = MyEvents(eventTitle: name, eventDescp: location, eventDate: dateTime, eventTime: selectedTime ?? TimeOfDay.now());
            Navigator.of(context).pop(event);
          },
          child: Text('添加', style: TextStyle(fontSize: getProportionateScreenWidth(32)),),
        ),
      ],
    );
  }
}

