import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationHelper {
  LocalNotificationHelper._();

  static final LocalNotificationHelper localNotificationHelper =
      LocalNotificationHelper._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void>showSimpleLocalPushNotification() async {
    AndroidNotificationDetails androidNotificationDetails =  const AndroidNotificationDetails(
      "simple" ,"simple notification channel",
      priority: Priority.max,importance: Importance.max,
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();
    NotificationDetails notificationDetails =NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      "simple Notification",
      "simple body",
      notificationDetails,
      payload: "Dummy payload with sample notification",
    );
  }


  Future<void>showScheduledLocalPushNotification() async {
    AndroidNotificationDetails androidNotificationDetails =  const AndroidNotificationDetails(
      "scheduled" ,"Scheduled notification channel",
      priority: Priority.max,importance: Importance.max,
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();
    NotificationDetails notificationDetails =NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "Scheduled Notification",
      "Scheduled body",
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "Dummy payload with sample notification",
    );
  }

  Future<void>showBigPictureLushNotification() async {
    BigPictureStyleInformation bigPictureStyleInformation = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher")
    );
    AndroidNotificationDetails androidNotificationDetails =   AndroidNotificationDetails(
      "Big picture" ,"Big picture notification channel",
      priority: Priority.max,importance: Importance.max,
      styleInformation: bigPictureStyleInformation,
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();
    NotificationDetails notificationDetails =NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      "Big picture Notification",
      "Big picture body",
      notificationDetails,
      payload: "Dummy payload with Big picture notification",
    );
  }


  Future<void>showMediaStyleLocalPushNotification() async {
    AndroidNotificationDetails androidNotificationDetails =  const AndroidNotificationDetails(
      "Media Style" ,"Media Style notification channel",
      priority: Priority.max,importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
        color: Colors.red,
      colorized: true,
      styleInformation: MediaStyleInformation(),
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();
    NotificationDetails notificationDetails =NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      "simple Notification",
      "simple body",
      notificationDetails,
      payload: "Dummy payload with sample notification",
    );
  }
}
