import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_app/views/phone_otp_auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dialCodeDigit = "+00";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Image.asset("assets/images/login.jpg"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Phone (otp) Authentication",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigit = country.dialCode!;
                  });
                },
                initialSelection: "IN",
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: const ["+1", "US", "+91", "IND"],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "phone Number",
                  prefix: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(dialCodeDigit),
                  ),
                ),
                maxLength: 12,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        phone: _controller.text,
                        codeDigit: dialCodeDigit,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
