import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/firebase_auth_helper.dart';

class deleteAccount extends StatefulWidget {
  const deleteAccount({Key? key}) : super(key: key);

  @override
  State<deleteAccount> createState() => _deleteAccountState();
}

class _deleteAccountState extends State<deleteAccount> {


  String? _Email;
  String? _password;
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final GlobalKey<FormState> deleteAccountlKey = GlobalKey<FormState>();

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
                    "delete your email",
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
                        "Confirm your Will be delete your\naccount",
                        style: TextStyle(
                          fontSize: Get.height * 0.025,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: deleteAccountlKey,
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
                              "Enter Email",
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
                            _Email = newValue!;
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
                            hintText: "Enter your deleted email",
                          ),
                          controller: EmailController,
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        TextFormField(
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                          validator: (value) =>
                          (value!.isEmpty) ? "Enter a deleted Password" : null,
                          textInputAction: TextInputAction.next,
                          // keyboardType: TextInputType.number,
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
                            hintText: "Enter your deleted Password",
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
                                  if (deleteAccountlKey.currentState!.validate()) {
                                    deleteAccountlKey.currentState!.save();
                                    FirebaseAuthHelper.firebaseAuthHelper.deletedUserAccount(_Email!, _password!);
                                    // FirebaseAuthHelper.firebaseAuthHelper.signOut();
                                  }
                                },
                                child: const Text(
                                  "Deleted your Account",
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
                          "Please check your Email and Password",
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

}
