import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:vaccine_app_project/screens/components/Default_Page.dart';
import 'package:vaccine_app_project/size_config.dart';

//設定行事曆的主要頁面
class AppColors {
  static const babyPowder = Color(0xFFFEFEFE);
  static const eggPlant = Color(0xFF614051);
  static const ultraRed = Color(0xFFFC6C85);
  static const blackCoffee = Color(0xFF3B2C35);
  static const blue = Color(0xFF90CAF9);
}

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
          hour: json['eventTime']['hour'], minute: json['eventTime']['minute']),
    );
  }

  @override
  String toString() => eventTitle;
}

class CalendarPage extends StatefulWidget {
  static String routeName = '/CalendarPage';

  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  TimeOfDay? selectedTime;
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  Map<DateTime, List<MyEvents>> mySelectedEvents = {};

  MyEvents? currentEvent;

  @override
  void initState() {
    super.initState();
    selectedCalendarDate = _focusedCalendarDate;
    loadAndCombineEvents();

  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  void loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('myEvents');
    if (encodedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(encodedData);
      setState(() {
        mySelectedEvents = decodedData.map((key, value) => MapEntry(
            DateTime.parse(key),
            value.map<MyEvents>((e) => MyEvents.fromJson(e)).toList()));
      });
    }
  }

  void saveEvents() async {

    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(
        mySelectedEvents.map((key, value) =>
            MapEntry(key.toIso8601String(),
                value.map((e) => e.toJson()).toList()))
    );

    // 儲存數據到 SharedPreferences
    bool result = await prefs.setString('myEvents', encodedData);

    // 檢查儲存是否成功
    if (result) {
      print("事件成功儲存");

      // 讀取剛剛儲存的數據並驗證
      String? savedData = prefs.getString('myEvents');
      if (savedData != null && savedData == encodedData) {
        print("數據已成功儲存");
      } else {
        print("未能檢索到數據");
      }
    } else {
      print("儲存事件失敗");
    }
  }

  int timeOfDayToMinutes(TimeOfDay tod) {
    return tod.hour * 60 + tod.minute;
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  List<MyEvents> _listOfAllEvents() {
    List<MyEvents> allEvents = [];

    // 如果 currentEvent 存在，首先添加它
    if (currentEvent != null) {
      allEvents.add(currentEvent!);
    }

    // 添加並排序來自 mySelectedEvents 的事件
    var tempEvents = mySelectedEvents.values.expand((v) => v).toList();
    tempEvents.sort((a, b) {
      if (a.eventDate == b.eventDate) {
        return timeOfDayToMinutes(a.eventTime)
            .compareTo(timeOfDayToMinutes(b.eventTime));
      }
      return a.eventDate.compareTo(b.eventDate);
    });
    allEvents.addAll(tempEvents);

    return allEvents;
  }

  void loadAndCombineEvents() async {
    final prefs = await SharedPreferences.getInstance();

    // 從 SharedPreferences 載入 'myEvents'
    String? encodedData = prefs.getString('myEvents');
    Map<DateTime, List<MyEvents>> tempMySelectedEvents = {};
    if (encodedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(encodedData);
      tempMySelectedEvents = decodedData.map((key, value) => MapEntry(
          DateTime.parse(key),
          value.map<MyEvents>((e) => MyEvents.fromJson(e)).toList()));
    }

    // 從 SharedPreferences 載入 'currentEvent'
    String? currentEventJson = prefs.getString('currentEvent');
    MyEvents? currentEvent;
    if (currentEventJson != null) {
      currentEvent = MyEvents.fromJson(jsonDecode(currentEventJson));
    }

    // 更新狀態以反映新的事件列表
    setState(() {
      mySelectedEvents = tempMySelectedEvents;
      this.currentEvent = currentEvent; // 分別儲存 currentEvent
    });
  }


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  // 插入新增事件的對話框
  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Event'),
        content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(400),
                    height: getProportionateScreenHeight(50),
                    child: buildTextField(controller: titleController, hint: '活動')),
                const SizedBox(height: 20.0),
                SizedBox(
                    width: getProportionateScreenWidth(400),
                    height: getProportionateScreenHeight(50),
                    child: buildTextField(controller: descpController, hint: '內容'),),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text(selectedTime?.format(context) ?? '時間'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[200],
                    onPrimary: Colors.white,
                    minimumSize: Size(200, 50),
                  ),
                ),
              ],
            ),
          ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消', style: TextStyle(color: Colors.pink[200], fontSize: getProportionateScreenHeight(15))),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  descpController.text.isEmpty ||
                  selectedTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('請輸入活動、內容、時間'),
                    duration: Duration(seconds: 3),
                  ),
                );
                return;
              } else {
                setState(() {
                  if (mySelectedEvents[selectedCalendarDate] != null) {
                    mySelectedEvents[selectedCalendarDate]?.add(
                      MyEvents(
                        eventDate: selectedCalendarDate!,
                        eventTitle: titleController.text,
                        eventDescp: descpController.text,
                        eventTime: selectedTime!,
                      ),
                    );
                  } else {
                    mySelectedEvents[selectedCalendarDate!] = [
                      MyEvents(
                        eventDate: selectedCalendarDate!,
                        eventTitle: titleController.text,
                        eventDescp: descpController.text,
                        eventTime: selectedTime!,
                      ),
                    ];
                  }
                  saveEvents();
                  _updateData();
                });
                titleController.clear();
                descpController.clear();
                selectedTime = null;
                calendarEventCount.value = getTotalNumberOfEvents();
                Navigator.pop(context);
                return;
              }
            },
            child: Text('添加', style: TextStyle(color: Colors.pink[200], fontSize: getProportionateScreenHeight(15))),
          ),
        ],
        actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }

  // 建立文本輸入小部件
  Widget buildTextField({
    String? hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.25),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.25),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  // 刪除事件
  void _deleteEvent(MyEvents event) async {
    final prefs = await SharedPreferences.getInstance();
    if (event == currentEvent) {
      // 如果刪除的是 currentEvent，則從 SharedPreferences 中清除
      await prefs.remove('currentEvent');
      setState(() {
        currentEvent = null;
        vaccineDeadline.value=0;
      });
    }
    setState(() {
      var eventsOnDate = mySelectedEvents[event.eventDate];
      if(eventsOnDate != null){
        eventsOnDate.remove(event);
        if(eventsOnDate.isEmpty){
          mySelectedEvents.remove(event.eventDate);
        }else{
          mySelectedEvents[event.eventDate] = eventsOnDate;
        }
      }
    });
    saveEvents();
  }

  // 取得事件總數
  int getTotalNumberOfEvents() {
    int totalCount = 0;


    if (currentEvent != null) {
      // 檢查是否在當天之前或當天
      if (currentEvent!.eventDate.isAfter(DateTime.now()) ||
          currentEvent!.eventDate.isAtSameMomentAs(DateTime.now())) {
        totalCount += 1;
      }
    }

    // 計算事件數
    mySelectedEvents.forEach((key, value) {
      // 只包括日期在當天之前或當天的事件
      if (key.isAfter(DateTime.now()) || key.isAtSameMomentAs(DateTime.now())) {
        totalCount += value.length;
      }
    });

    return totalCount;
  }


  Future<void> _updateData() async {
    setState(() {
      calendarEventCount.value = getTotalNumberOfEvents();
    });
  }


  @override
  Widget build(BuildContext context) {
    _updateData();
    return DefaultPage(
      iconOfColor: kColorStyle333,
      backGroundImage: 'assets/images/back02.png',
      press: () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/MainPage", (Route<dynamic> route) => false);
        _updateData();
      },
      body: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                        text: TextSpan(
                          text: "行事曆",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(45),
                            color: kColorStyle111,
                          ),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width*0.22,),
                    Padding(
                      padding: EdgeInsets.only(right: getProportionateScreenWidth(50)),
                      child: InkWell(
                        onTap: () {
                          _showAddEventDialog();
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '+',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(50),
                                  color: kColorStyle111,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Card(
                  margin: const EdgeInsets.all(1.0),
                  elevation: 5.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    side: BorderSide(color: AppColors.blackCoffee, width: 2.0),
                  ),
                  child: SizedBox(
                    height: getProportionateScreenHeight(310),
                    width: getProportionateScreenWidth(750),
                    child: TableCalendar(
                      shouldFillViewport: true,
                      focusedDay: _focusedCalendarDate,
                      firstDay: _initialCalendarDate,
                      lastDay: _lastCalendarDate,
                      selectedDayPredicate: (day) =>
                          isSameDay(selectedCalendarDate, day),
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedCalendarDate = focusedDay;
                        });
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          selectedCalendarDate = selectedDay;
                          _focusedCalendarDate = focusedDay;
                        });
                      },
                      eventLoader: _listOfDayEvents,
                      calendarStyle: const CalendarStyle(
                        isTodayHighlighted: true,
                        todayDecoration: BoxDecoration(
                          color: AppColors.ultraRed,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: AppColors.ultraRed,
                              width: 2.0,
                            ),
                          ),
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            constraints:
            BoxConstraints(maxHeight: getProportionateScreenHeight(235)),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(5)),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _listOfAllEvents().length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  margin:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8.0),
                  elevation: 2.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: ListTile(
                    title: Text(_listOfAllEvents()[index].eventTitle),
                    subtitle: Text(
                      '${_listOfAllEvents()[index].eventDescp} at ${_listOfAllEvents()[index].eventTime.format(context)} on ${_listOfAllEvents()[index].eventDate.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: AppColors.ultraRed),
                      onPressed: () {
                        _deleteEvent(_listOfAllEvents()[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
