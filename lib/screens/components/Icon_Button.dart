import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_app_project/screens/Main_Page/message_page.dart';
import '../../constants.dart';
import '../Calendar/Calendar_Page.dart';
import '../Report/Report_Day.dart';
import 'Main_Bar_Button.dart';

//設定右上角3個Icon的圖示以及功能
class IconButtons extends StatefulWidget{
  const IconButtons({super.key, required this.iconOfColor});
  final Color iconOfColor;

  @override
  State<IconButtons> createState() => _IconButtonsState();
}

class _IconButtonsState extends State<IconButtons> {

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MainBarButton(svgSrc: "assets/icons/view.svg", num: messageCount.value, iconOfColor: widget.iconOfColor ,press: () {
          if (ModalRoute.of(context)?.settings.name != '/MessagePage'){ //判斷當前頁面是否為自己 如果是就不會再次切換頁面
          Navigator.pushNamed(context, MessagePage.routeName);
          }
        }
        ),
        MainBarButton(svgSrc: "assets/icons/Clock2.svg", num: vaccineDeadline.value, iconOfColor: widget.iconOfColor ,press: (){
           if (ModalRoute.of(context)?.settings.name != '/ReportDay'){ //判斷當前頁面是否為自己 如果是就不會再次切換頁面
          Navigator.pushNamed(context, ReportDay.routeName);
           }
        }
        ),
        MainBarButton(svgSrc: "assets/icons/Deadline2.svg", num: calendarEventCount.value, iconOfColor: widget.iconOfColor ,press: (){
          if (ModalRoute.of(context)?.settings.name != '/CalendarPage'){ //判斷當前頁面是否為自己 如果是就不會再次切換頁面
            Navigator.pushNamed(context, CalendarPage.routeName);
          }
        }
        ),
      ],
    );
  }
}