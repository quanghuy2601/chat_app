import 'dart:async';

import 'package:chat_app/screens/signin_screen.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool invalidOtp = false;
  int resendTime = 60;
  late Timer countdownTimer;
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();
  TextEditingController txt5 = TextEditingController();
  TextEditingController txt6 = TextEditingController();

  EmailOTP myAuth = EmailOTP();

  @override
  void initState() {
    sendOTP();
    print(widget.email);
    startTimer();
    super.initState();
  }

  sendOTP() async {
    myAuth.setConfig(
      appEmail: "quanghuy7927@gmail.com",
      appName: "chat-app",
      userEmail: widget.email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );

    if (await myAuth.sendOTP() == true) {
      print("OTP has been sent");
    } else {
      print("Oops, OTP send failed");
    }
  }

  Future<bool> checkOTP() async {
    String otp = txt1.text + txt2.text + txt3.text + txt4.text + txt5.text + txt6.text;
    if (await myAuth.verifyOTP(otp: otp) == true) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Mã Xác Nhận',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nhập 6 số mà bạn đã nhận trong email',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myInputBox(context, txt1),
                    myInputBox(context, txt2),
                    myInputBox(context, txt3),
                    myInputBox(context, txt4),
                    myInputBox(context, txt5),
                    myInputBox(context, txt6),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Nếu bạn chưa nhận dược mã OTP?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    resendTime == 0
                        ? InkWell(
                            onTap: () {
                              // Resend OTP Code
                              invalidOtp = false;
                              resendTime = 60;
                              startTimer();
                              //
                            },
                            child: const Text(
                              'Gửi lại',
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                const SizedBox(height: 10),
                resendTime != 0
                    ? Text(
                        'Bạn có thể nhận lại mã OTP sau ${(resendTime)} giây',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      )
                    : const SizedBox(),
                const SizedBox(height: 5),
                Text(
                  invalidOtp ? 'Invalid otp!' : '',
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (await checkOTP()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    } else {
                      _showDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color.fromRGBO(163, 52, 250, 1),
                  ),
                  child: const Text(
                    'Xác Nhận',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myInputBox(BuildContext context, TextEditingController controller) {
    return Container(
      height: 70,
      width: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 105, 104, 1),
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        cursorColor: Colors.white,
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 42),
        decoration: const InputDecoration(
          counterText: '',
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.white,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Thông báo"),
          content: const Text("Bạn đã nhập sai mã OTP. Vui lòng kiểm tra lại."),
          actions: <Widget>[
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        );
      },
    );
  }
}
