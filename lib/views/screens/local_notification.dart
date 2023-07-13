import 'package:firebase_app/utils/fcm_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../utils/local_notification_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Local_notification extends StatefulWidget {
  const Local_notification({Key? key}) : super(key: key);

  @override
  State<Local_notification> createState() => _Local_notificationState();
}

class _Local_notificationState extends State<Local_notification>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings arwinInitializationSettings =
        const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: arwinInitializationSettings,
    );

    tz.initializeTimeZones();
    LocalNotificationHelper.flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("============");
        print("PLAYLOAD : ${response.payload}");
        print("============");
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("===============");
    print(state);
    print("===============");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () async {
              await LocalNotificationHelper.localNotificationHelper
                  .showSimpleLocalPushNotification();
            },
            child: const Text(
              "Simple Notification",
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () async {
              await LocalNotificationHelper.localNotificationHelper
                  .showScheduledLocalPushNotification();
            },
            child: const Text(
              "Scheduled Notification",
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () async {
              await LocalNotificationHelper.localNotificationHelper
                  .showBigPictureLushNotification();
            },
            child: const Text(
              "Big Screen Notification",
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () async {
              await LocalNotificationHelper.localNotificationHelper
                  .showMediaStyleLocalPushNotification();
            },
            child: const Text(
              "Media Style Notification",
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () async {
              await FCMHelper.fcmHelper.sendFcmByApi();
            },
            child: const Text(
              "Send FCM by API",
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                ),
                onPressed: () async {
                  await FCMHelper.fcmHelper.subScribe(topic: "sport");
                },
                child: const Text(
                  "Subscribe",
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey,
                  ),
                ),
                onPressed: () async {
                  await FCMHelper.fcmHelper.unSubScribe(topic: "sport");
                },
                child: const Text(
                  "UnSubscribe",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
