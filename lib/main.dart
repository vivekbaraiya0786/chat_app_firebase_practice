import 'package:firebase_app/views/screens/HomePage.dart';
import 'package:firebase_app/views/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
       GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/',page: () => const LoginPage(),),
          GetPage(name: '/HomePage',page: () => const HomePage(),),
        ],
      )
  );
}