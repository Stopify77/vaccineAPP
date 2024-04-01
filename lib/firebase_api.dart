import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_app_project/main.dart';
import 'package:vaccine_app_project/screens/Log_in/login_screen.dart';
import 'package:vaccine_app_project/screens/Main_Page/message_page.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title:${message.notification?.title}");
  print("Body:${message.notification?.body}");
  print("Payload:${message.data}");
}

Future<void> alreadyLogin() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedUsername = prefs.getString('username');
  if (savedUsername!.isEmpty){
    navigatorKey.currentState?.pushNamed(LoginScreen.routeName);
  }else{
    navigatorKey.currentState?.pushNamed(MessagePage.routeName);
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("ic_launcher.png");

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body,
            String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (
            NotificationResponse notificationResponse) async {});
  }
  notificationDetails(){
    return const NotificationDetails(
        android: AndroidNotificationDetails("彈跳視窗", "推播通知", icon: "ic_launcher",
            importance: Importance.max),
        iOS: DarwinNotificationDetails()
    );
  }

  Future showNotification({int id = 0,String? title, String? body, String? payload})async{
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token:$fCMToken");

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message){
    if (message == null) return;
    // navigatorKey.currentState?.pushNamed(MessagePage.routeName);
    alreadyLogin();
  }

  Future initPushNotifications() async{
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((message){
      final notification = message.notification;
      if (notification == null) return;
      NotificationService().showNotification(title: notification.title, body: notification.body);
    });
  }
}
