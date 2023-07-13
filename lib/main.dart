import 'package:firebase_app/views/phone_otp_auth/login_screen.dart';
import 'package:firebase_app/views/phone_otp_auth/otp_screen.dart';
import 'package:firebase_app/views/screens/HomePage.dart';
import 'package:firebase_app/views/screens/chat_page.dart';
import 'package:firebase_app/views/screens/local_notification.dart';
import 'package:firebase_app/views/screens/login_page.dart';
import 'package:firebase_app/views/screens/sign_up_email_verification.dart';
import 'package:firebase_app/views/twitter/login_screen.dart';
import 'package:firebase_app/views/twitter/register_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/delete_account.dart';
import 'components/update_Email.dart';
import 'components/update_password.dart';
@pragma('vm:entry-point')


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("=====BACKGROUND======");
  print("Notification Title : ${message.notification!.title}");
  print("Notification body : ${message.notification!.body}");

  print("Data :${message.data}");
  print("===========");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("=====FOREGROUND======");
    print("Notification Title : ${message.notification!.title}");
    print("Notification body : ${message.notification!.body}");

    print("Data :${message.data}");
    print("===========");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/HomePage',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/update_Email',
          page: () => const update_Email(),
        ),
        GetPage(
          name: '/update_Password',
          page: () => const update_Password(),
        ),
        GetPage(
          name: '/deleteAccount',
          page: () => const deleteAccount(),
        ),
        GetPage(
          name: '/register-screen',
          page: () =>  const TwitterRegistrationScreen(),
        ),
        GetPage(
          name: '/TwitterLoginScreen',
          page: () =>  const TwitterLoginScreen(),
        ),
        GetPage(
          name: '/LoginScreen',
          page: () =>  const LoginScreen(),
        ),
        GetPage(
          name: '/OtpScreen',
          page: () =>  OtpScreen(phone: '', codeDigit: '',),
        ),
        GetPage(
          name: '/chat_page',
          page: () =>  const chat_page(),
        ),GetPage(
          name: '/Local_notification',
          page: () =>  const Local_notification(),
        ),GetPage(
          name: '/signup_Verification',
          page: () =>  const SignupVerification(),
        ),
      ],
    ),
  );
}
