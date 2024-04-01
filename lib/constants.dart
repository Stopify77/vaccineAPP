import 'package:flutter/material.dart';

// 設定各個參數 以便後續使用
String VMURL = "http://122.117.204.53:10001/";

const kTextColor = Color(0xFF9C9799);
const kPrimaryColor = Color(0xFFFFFFFF);
const kSecondaryColor = Color(0xFF5D6A96);
const kThirdColor = Color(0xFF8692C7);
const double kDefaultPadding = 15.0;

const kColorStyle1 = Color(0xFFEBEFF4);
const kColorStyle11 = Color(0xFFFFD3E3);
const kColorStyle111 = Color(0xFFEBA6BF);

const kColorStyle2 = Color(0xFFCFE8FA);
const kColorStyle22 = Color(0xFF90B7D4);
const kColorStyle222 = Color(0xFF6291B4);

const kColorStyle3 = Color(0xFFB9C3E4);
const kColorStyle33 = Color(0xFF8493C4);
const kColorStyle333 = Color(0xFF5C6A97);

const kColorStyle4 = Color(0xFFA5959B);
const kColorStyle44 = Color(0xFF897F83);
const kColorStyle444 = Color(0xFF5A4F53);

const kAnimationDuration = Duration(milliseconds: 200);

const String kAccountNullError = "請輸入帳號";
const String kPassNullError = "請輸入密碼";
const String kInvaildAccountPassword = "帳號或密碼錯誤";

var messageCount = ValueNotifier<int>(0);
var vaccineDeadline = ValueNotifier<int>(0);
var calendarEventCount = ValueNotifier<int>(0);

var onlineCount = ValueNotifier<String>("0");
var clickedCount = ValueNotifier<String>("0");

var accountName = ValueNotifier<String>("");
var accountPassword = ValueNotifier<String>("");
var stressScore = ValueNotifier<double>(0);

var pushNotification = ValueNotifier<int>(0);
var doneTest = ValueNotifier<bool>(false);

var needTest = ValueNotifier<bool>(false);
var testNumber = ValueNotifier<String>("");


var doMain = ValueNotifier<String>("");

