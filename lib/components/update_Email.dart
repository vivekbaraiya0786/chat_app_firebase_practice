import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/firebase_auth_helper.dart';

class update_Email extends StatefulWidget {
  const update_Email({Key? key}) : super(key: key);

  @override
  State<update_Email> createState() => _update_EmailState();
}

class _update_EmailState extends State<update_Email> {


  String? _newEmail;
  final TextEditingController EmailController = TextEditingController();
  final GlobalKey<FormState> updateEmailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    "Update your email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height * 0.026,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Confirm your New Email and we'll send \nthe instruction",
                        style: TextStyle(
                          fontSize: Get.height * 0.025,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: updateEmailKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.email_outlined),
                            SizedBox(
                              width: Get.height * 0.01,
                            ),
                            Text(
                              "Your updated Email",
                              style: TextStyle(
                                fontSize: Get.height * 0.015,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        TextFormField(
                          onSaved: (newValue) {
                            _newEmail = newValue!;
                          },
                          validator: (value) =>
                          (value!.isEmpty) ? "Enter a updated Email" : null,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: "Enter your updated email",
                          ),
                          controller: EmailController,
                        ),
                        SizedBox(
                          height: Get.height * 0.095,
                        ),
                        SizedBox(
                          height: Get.height * 0.07,
                          width: Get.width * 0.9,
                          child: OutlinedButtonTheme(
                            data: OutlinedButtonThemeData(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    // spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                                ),
                                onPressed: () {
                                  if (updateEmailKey.currentState!.validate()) {
                                    updateEmailKey.currentState!.save();
                                    // sendPasswordResetEmail();
                                    updateUserEmail();
                                    Get.back();
                                  }
                                },
                                child: const Text(
                                  "Update your email",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.09,
                        ),
                        const Text(
                          "Please check your updated email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateUserEmail() async {
   await FirebaseAuthHelper.firebaseAuthHelper
        .updateUserEmail(_newEmail!);
    Get.snackbar(
      "Update Email",
      "You have been successfully Update Email",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
