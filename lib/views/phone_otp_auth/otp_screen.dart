import 'package:firebase_app/views/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final String codeDigit;

  OtpScreen({required this.phone, required this.codeDigit});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOtpController = TextEditingController();
  final FocusNode _pinOtpCodeFoucus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOTPDecoration = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.grey,
    ),
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigit + widget.phone}",
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        });
      },
      verificationFailed: (FirebaseAuthException e){
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          verificationCode = verificationId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP sent to ${widget.codeDigit}-${widget.phone}'),
            duration: Duration(seconds: 3),
          ),
        );
      },

      codeAutoRetrievalTimeout: (String vId){
        setState(() {
          verificationCode = vId;
        });
    },
    timeout: Duration(seconds: 30),
    );
  }
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset("assets/images/otp.png"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhoneNumber();
                },
                child: Text(
                  "Verifying : ${widget.codeDigit}-${widget.phone}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              40,
            ),
            child: Pinput(
              length: 6,
              // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
              focusNode: _pinOtpCodeFoucus,
              controller: _pinOtpController,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(30, 60, 87, 1),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
                ),
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
              pinAnimationType: PinAnimationType.rotation,
              onChanged: (otp) async {
                if (otp.length == 6) {
                  _pinOtpController.text = otp;
                  _pinOtpController.selection = TextSelection.fromPosition(
                    TextPosition(offset: otp.length),
                  );
                  FocusScope.of(context).unfocus();
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: verificationCode!, smsCode: otp))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  HomePage(),
                        ));
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Sign in WIth phone Number",
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                }
              },
              // onSubmitted: (pin) async {
              //   try {
              //     await FirebaseAuth.instance
              //         .signInWithCredential(PhoneAuthProvider.credential(
              //             verificationId: verificationCode!, smsCode: pin))
              //         .then((value) {
              //       if (value.user != null) {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) =>  HomePage(),
              //         ));
              //       }
              //     });
              //   } catch (e) {
              //     FocusScope.of(context).unfocus();
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //         content: Text(
              //           "Sign in WIth phone Number",
              //         ),
              //         duration: Duration(seconds: 3),
              //       ),
              //     );
              //   }
              // },
            ),
          ),
        ],
      ),
    );
  }
}
