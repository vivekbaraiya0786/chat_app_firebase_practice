import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/firebase_auth_helper.dart';

class update_Password extends StatefulWidget {
  const update_Password({Key? key}) : super(key: key);

  @override
  State<update_Password> createState() => _update_PasswordState();
}

class _update_PasswordState extends State<update_Password> {


  final TextEditingController PasswordController = TextEditingController();
  final GlobalKey<FormState> updatePasswordKey = GlobalKey<FormState>();

  String _newPassword = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                    "Update Your Password",
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
                        "Confirm your Updated Email and we'll\nsend the instruction",
                        style: TextStyle(
                          fontSize: Get.height * 0.025,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: updatePasswordKey,
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
                              "Your Email",
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
                            _newPassword = newValue!;
                          },
                          validator: (value) =>
                          (value!.isEmpty) ? "Enter a updated Password" : null,
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
                            hintText: "Enter your Updated Password",
                          ),
                          controller: PasswordController,
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
                                  if (updatePasswordKey.currentState!.validate()) {
                                    updatePasswordKey.currentState!.save();
                                    // sendPasswordResetEmail();
                                    updatePassword();
                                    Get.back();
                                  }
                                },
                                child: const Text(
                                  "Update your Password",
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
                          "Please check your updated Password",
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
  Future<void> updatePassword() async {
    await FirebaseAuthHelper.firebaseAuthHelper
        .updatePassword(_newPassword);
    Get.snackbar(
      "Update Password",
      "You have been successfully Update Password",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}
