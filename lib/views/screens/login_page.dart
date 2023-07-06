import 'package:firebase_app/utils/firebase_auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> signinKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPassWordkey = GlobalKey<FormState>();
  final GlobalKey<FormState> updatePasswordKey = GlobalKey<FormState>();

  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  final TextEditingController signupUserNameController =
      TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController forgotPasswordController =
      TextEditingController();

  String? Email;
  String? Password;

  String? signupUserName;

  int intialIndex = 0;

  //verifaction page

  final verificationkey = GlobalKey<FormState>();
  final TextEditingController _verificationemailController =
      TextEditingController();
  final TextEditingController _verificationpasswordController =
      TextEditingController();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          bool willPop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Alert !!"),
              content: const Text("Are yo sure to Exit the resume builder !!"),
              actions: [
                Theme(
                  data: ThemeData(
                    useMaterial3: true,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes"),
                  ),
                ),
                Theme(
                  data: ThemeData(
                    useMaterial3: true,
                  ),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No"),
                  ),
                ),
              ],
            ),
          );
          return willPop;
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    IndexedStack(
                      index: intialIndex,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * 0.033,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.07,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            Form(
                              key: signinKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.024,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.person_outline),
                                      SizedBox(
                                        width: Get.height * 0.01,
                                      ),
                                      Text(
                                        "Your Email/User Name",
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
                                      Email = newValue;
                                    },
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Email"
                                        : null,
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
                                      hintText: "Enter your Email",
                                    ),
                                    controller: EmailController,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.025,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.lock_outline_rounded),
                                      SizedBox(
                                        width: Get.height * 0.01,
                                      ),
                                      Text(
                                        "Password",
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
                                    controller: PasswordController,
                                    onSaved: (newValue) {
                                      Password = newValue;
                                    },
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Password"
                                        : null,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
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
                                      hintText: "Enter Your Password",
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.015,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        intialIndex = 2;
                                      });
                                    },
                                    child: const Text("Forgot Password?"),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.9,
                                    child: OutlinedButtonTheme(
                                      data: OutlinedButtonThemeData(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.5),
                                              // spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blueAccent),
                                          ),
                                          onPressed: () {
                                            if (signinKey.currentState!
                                                .validate()) {
                                              signinKey.currentState!.save();
                                            }
                                            LoginWithEmailPassword0();
                                          },
                                          child: const Text(
                                            "Login",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: "Are you new user? ",
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              setState(() {
                                                intialIndex = 1;
                                              });
                                            },
                                          text: "Sing Up",
                                          style: const TextStyle(
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  //without try catch

                                  // onTap: () async{
                                  //   User? user = await FirebaseAuthHelper.firebaseAuthHelper.signInWithGoogle();
                                  //
                                  //   if (user != null) {
                                  //     Get.snackbar(
                                  //       'Successfully',
                                  //       "Login Successfully",
                                  //       backgroundColor: Colors.green,
                                  //       snackPosition: SnackPosition.BOTTOM,
                                  //       duration: const Duration(seconds: 2),
                                  //     );
                                  //     Get.offAllNamed('/HomePage');
                                  //   } else {
                                  //     Get.snackbar(
                                  //       'Failed',
                                  //       "Login Failed",
                                  //       backgroundColor: Colors.red,
                                  //       snackPosition: SnackPosition.BOTTOM,
                                  //       duration: const Duration(seconds: 2),
                                  //     );
                                  //   }
                                  //
                                  //
                                  // },

                                  //with try catch

                                  onTap: () async {
                                    Map<String, dynamic> data =
                                        await FirebaseAuthHelper
                                            .firebaseAuthHelper
                                            .signInWithGoogle();

                                    if (data['user'] != null) {
                                      Get.snackbar(
                                        'Successfully',
                                        "Login Successfully",
                                        backgroundColor: Colors.green,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                      );
                                      Get.offAllNamed('/HomePage',
                                          arguments: data['user']);
                                    } else {
                                      Get.snackbar(
                                        'Failed',
                                        data['msg'],
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  },

                                  child: const CircleAvatar(
                                    child: Icon(Icons.g_mobiledata),
                                  ),
                                ),
                                GestureDetector(
                                  //without try catch

                                  // onTap: () async {
                                  //   User? user = await FirebaseAuthHelper
                                  //       .firebaseAuthHelper
                                  //       .signInAnonymously();
                                  //   if (user != null) {
                                  //     Get.snackbar(
                                  //       'Successfully',
                                  //       "Login Successfully",
                                  //       backgroundColor: Colors.green,
                                  //       snackPosition: SnackPosition.BOTTOM,
                                  //       duration: const Duration(seconds: 2),
                                  //     );
                                  //   } else {
                                  //     Get.snackbar(
                                  //       'Failed',
                                  //       "Login Failed",
                                  //       backgroundColor: Colors.red,
                                  //       snackPosition: SnackPosition.BOTTOM,
                                  //       duration: const Duration(seconds: 2),
                                  //     );
                                  //   }
                                  //   Get.toNamed("/HomePage");
                                  // },

                                  //with try catch

                                  onTap: () async {
                                    Map<String, dynamic> data =
                                        await FirebaseAuthHelper
                                            .firebaseAuthHelper
                                            .signInAnonymously();
                                    if (data['user'] != null) {
                                      Get.snackbar(
                                        'Successfully',
                                        "Login Successfully",
                                        backgroundColor: Colors.green,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                      );
                                      Get.toNamed("/HomePage",
                                          arguments: data["user"]);
                                    } else {
                                      Get.snackbar(
                                        'Failed',
                                        data['msg'],
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  },
                                  child: const CircleAvatar(
                                    child: Icon(Icons.person_outline),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    child: Icon(Icons.facebook),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      intialIndex = 3;
                                    });
                                  },
                                  child: const CircleAvatar(
                                    child: Icon(Icons.verified),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      intialIndex = 0;
                                    });
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
                              "Create Account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * 0.033,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Form(
                              key: signupKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.024,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.person_outline),
                                      SizedBox(
                                        width: Get.height * 0.01,
                                      ),
                                      Text(
                                        "Your FullName",
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
                                      signupUserName = newValue;
                                    },
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Name"
                                        : null,
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
                                      hintText: "Enter your Name",
                                    ),
                                    controller: signupUserNameController,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.015,
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
                                      Email = newValue;
                                    },
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Email"
                                        : null,
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
                                      hintText: "Enter your Email",
                                    ),
                                    controller: EmailController,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.015,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.lock_outline_rounded),
                                      SizedBox(
                                        width: Get.height * 0.01,
                                      ),
                                      Text(
                                        "Password",
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
                                    controller: PasswordController,
                                    onSaved: (newValue) {
                                      Password = newValue;
                                    },
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Password"
                                        : null,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
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
                                      hintText: "Enter Your Password",
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.053,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.9,
                                    child: OutlinedButtonTheme(
                                      data: OutlinedButtonThemeData(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.5),
                                              // spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blueAccent),
                                          ),
                                          onPressed: () {
                                            if (signupKey.currentState!
                                                .validate()) {
                                              signupKey.currentState!.save();
                                            }
                                            validateAndSignUp();
                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: "Already User? ",
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              setState(() {
                                                intialIndex = 0;
                                              });
                                            },
                                          text: "Login",
                                          style: const TextStyle(
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    child: Icon(Icons.g_mobiledata),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    child: Icon(Icons.snapchat),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    child: Icon(Icons.facebook),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      intialIndex = 0;
                                    });
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
                              "Reset Your Password",
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
                                  "Confirm your Email and we'll send \nthe instruction",
                                  style: TextStyle(
                                    fontSize: Get.height * 0.025,
                                    height: 1.5,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Form(
                              key: forgotPassWordkey,
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
                                      Email = newValue;
                                    },
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Email"
                                        : null,
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
                                      hintText: "Enter your Email",
                                    ),
                                    controller: forgotPasswordController,
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.5),
                                              // spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blueAccent),
                                          ),
                                          onPressed: () {
                                            if (forgotPassWordkey.currentState!
                                                .validate()) {
                                              forgotPassWordkey.currentState!
                                                  .save();
                                              sendPasswordResetEmail();
                                            }
                                          },
                                          child: const Text(
                                            "Send Instruction",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.09,
                                  ),
                                  const Text(
                                    "Please check your mail",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      intialIndex = 0;
                                    });
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
                              "Register Account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * 0.033,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Form(
                              key: verificationkey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.024,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.person_outline),
                                      SizedBox(
                                        width: Get.height * 0.01,
                                      ),
                                      Text(
                                        "Your FullName",
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
                                    controller: _verificationemailController,
                                    onSaved: (newValue) {
                                      email = newValue;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: const Icon(Icons.email),
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
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.025,
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
                                    controller: _verificationpasswordController,
                                    onSaved: (newValue) {
                                      password = newValue;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: const Icon(Icons.lock),
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
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                   SizedBox(height: Get.height * 0.1),
                                  SizedBox(
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.9,
                                    child: OutlinedButtonTheme(
                                      data: OutlinedButtonThemeData(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.5),
                                              // spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                        child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueAccent),
                                          ),
                                          onPressed: () async {
                                            if (verificationkey.currentState!
                                                .validate()) {
                                              verificationkey.currentState!.save();
                                              FirebaseAuthHelper.firebaseAuthHelper
                                                  .createUserWithEmailAndPassword(
                                                  email!, password!);
                                              Get.snackbar(
                                                'verification',
                                                'verification code successfully sent in this email..',
                                                snackPosition: SnackPosition.BOTTOM,
                                              );
                                              setState(() {
                                                intialIndex = 0;
                                              });
                                            }
                                          },
                                          child: const Text(
                                            "Register",
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //without try catch

  // Future<void> validateAndSignUp() async {
  //   if (signupKey.currentState!.validate()) {
  //     (signupKey.currentState!.save());
  //
  //     User? user = await FirebaseAuthHelper.firebaseAuthHelper
  //         .signupWithEmailPassword(email: Email!, password: Password!);
  //
  //     if (user != null) {
  //       Get.snackbar(
  //         'Successfully',
  //         "Login Successfully",
  //         backgroundColor: Colors.green,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 2),
  //       );
  //     } else {
  //       Get.snackbar(
  //         'Failed',
  //         "Login Failed",
  //         backgroundColor: Colors.red,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 2),
  //       );
  //     }
  //   }
  // }

//with try and catch
  Future<void> validateAndSignUp() async {
    if (signupKey.currentState!.validate()) {
      (signupKey.currentState!.save());

      Map<String, dynamic> data = await FirebaseAuthHelper.firebaseAuthHelper
          .signupWithEmailPassword(email: Email!, password: Password!);

      if (data['user'] != null) {
        Get.snackbar(
          'Successfully',
          "Login Successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Failed',
          data['msg'],
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

//without try catch

  // Future<void> LoginWithEmailPassword0() async {
  //   if (signupKey.currentState!.validate()) {
  //     (signupKey.currentState!.save());
  //
  //     User? user = await FirebaseAuthHelper.firebaseAuthHelper
  //         .signinWithEmailPassword(email: Email!, password: Password!);
  //
  //     if (user != null) {
  //       Get.snackbar(
  //         'Successfully',
  //         "Login Successfully",
  //         backgroundColor: Colors.green,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 2),
  //       );
  //     } else {
  //       Get.snackbar(
  //         'Failed',
  //         "Login Failed",
  //         backgroundColor: Colors.red,
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 2),
  //       );
  //     }
  //     Get.offNamed("/HomePage");
  //   }
  // }

//with try catch

  Future<void> LoginWithEmailPassword0() async {
    if (signupKey.currentState!.validate()) {
      (signupKey.currentState!.save());

      Map<String, dynamic> data = await FirebaseAuthHelper.firebaseAuthHelper
          .signinWithEmailPassword(email: Email!, password: Password!);

      if (data['user'] != null) {
        Get.snackbar(
          'Successfully',
          "Login Successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        Get.offNamed("/HomePage", arguments: data['user']);
      } else {
        Get.snackbar(
          'Failed',
          data['msg'],
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> sendPasswordResetEmail() async {
    await FirebaseAuthHelper.firebaseAuthHelper.sendPasswordResetEmail(Email!);
    Get.snackbar(
      "Reset Password",
      "You have Sent been mail",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
