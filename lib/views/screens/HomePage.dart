import 'package:firebase_app/utils/firebase_auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.08,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("${user!.photoURL}"),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            (user.isAnonymous)
                ? const Text("")
                : (user.displayName == null)
                    ? const Text("")
                    : Text("UserName : ${user.displayName}"),
            SizedBox(
              height: Get.height * 0.02,
            ),
            (user.isAnonymous)
            ?const Text("")
                :Text("Email : ${user.email}"),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(CupertinoIcons.power),
          ),
        ],
      ),
      body: Container(),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuthHelper.firebaseAuthHelper.signOut();
    Get.offAllNamed("/");
    Get.snackbar(
      "Signed Out",
      "You have been successfully signed out",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
