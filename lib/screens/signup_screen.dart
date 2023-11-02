import 'dart:convert';

import 'package:chat_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  final TextStyle _validStyle = const TextStyle(color: Colors.green);
  final TextStyle _inValidStyle = const TextStyle(color: Colors.red);
  final TextStyle _defaultStyle = const TextStyle(color: Colors.grey);

  bool _isUsernameValid = false;
  bool _isMailValid = false;
  bool _isValidPassword = false;
  bool _isConfirmPassword = false;
  bool _isGender = false;
  bool _isBirthday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Column(
                children: <Widget>[
                  SizedBox(height: 60.0),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Điền thông tin tài khoản",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      bool hasLowercase = false;
                      bool hasDigit = false;

                      for (int i = 0; i < value.length; i++) {
                        if (value[i].toLowerCase() == value[i] && value[i].toUpperCase() != value[i]) {
                          hasLowercase = true;
                        } else if (int.tryParse(value[i]) != null) {
                          hasDigit = true;
                        }
                      }
                      if (hasLowercase && hasDigit) {
                        setState(() {
                          _isUsernameValid = true;
                        });
                      } else {
                        setState(() {
                          _isUsernameValid = false;
                        });
                      }
                    },
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _validText("Username phải đủ chữ và số", _isUsernameValid ? _validStyle : _inValidStyle),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      const pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                      final regExp = RegExp(pattern);
                      if (regExp.hasMatch(value)) {
                        setState(() {
                          _isMailValid = true;
                        });
                      } else {
                        _isMailValid = false;
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _validText("Địa chỉ mail hợp lệ.", _isMailValid ? _validStyle : _inValidStyle),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      const pattern = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$';
                      final regExp = RegExp(pattern);

                      if (regExp.hasMatch(value)) {
                        setState(() {
                          _isValidPassword = true;
                        });
                      } else {
                        setState(() {
                          _isValidPassword = false;
                        });
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                    ),
                    obscuringCharacter: "*",
                    obscureText: true,
                  ),
                  _validText("Mật khẩu hợp lệ.", _isValidPassword ? _validStyle : _inValidStyle),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      if (value == _passwordController.text) {
                        setState(() {
                          _isConfirmPassword = true;
                        });
                      } else {
                        setState(() {
                          _isConfirmPassword = false;
                        });
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                    ),
                    obscuringCharacter: "*",
                    obscureText: true,
                  ),
                  _validText("Mật khẩu trùng khớp.", _isConfirmPassword ? _validStyle : _inValidStyle),
                  const SizedBox(height: 10),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _fullnameController,
                    decoration: InputDecoration(
                      hintText: "Fullname",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      if (value == "Nam" || value == "Nu") {
                        setState(() {
                          _isGender = true;
                        });
                      } else {
                        setState(() {
                          _isGender = false;
                        });
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _genderController,
                    decoration: InputDecoration(
                      hintText: "Gender",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.person_3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _validText("Ví dụ: 'Nam' hoặc 'Nu'", _isGender ? _validStyle : _inValidStyle),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      const pattern = r'^\d{2}/\d{2}/\d{4}$';
                      final regExp = RegExp(pattern);

                      if (regExp.hasMatch(value)) {
                        setState(() {
                          _isBirthday = true;
                        });
                      } else {
                        setState(() {
                          _isBirthday = false;
                        });
                      }
                    },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      hintText: "Birthday",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.cake,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _validText("Ngày sinh hợp lệ. Ví dụ '11/12/2000'", _isBirthday ? _validStyle : _inValidStyle),
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      // call api for sign up
                      _signup(
                        _usernameController.text,
                        _passwordController.text,
                        _emailController.text,
                        _fullnameController.text,
                        _genderController.text,
                        _birthdayController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> _signup(
    String username,
    String password,
    String email,
    String fullname,
    String gender,
    String birthday,
  ) {
    return http.post(
      Uri.parse('https://d30b-2402-800-63b9-ce8f-441f-6e18-f9b0-8d8e.ngrok-free.app/api/auth/register'),
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          //'username': username,
          'email': email,
          'password': password,
          'fullname': fullname,
          'gender': gender,
          'birthday': birthday,
        },
      ),
    );
  }

  Widget _validText(String content, TextStyle style) {
    return Text(
      content,
      style: style,
    );
  }

  String normalizeString(String input) {
    List<String> words = input.split(' ');

    words.removeWhere((word) => word.isEmpty);

    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toLowerCase();
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }

    return words.join(' ');
  }
}

/*
'eaea48d61242c574c2ca331d47de60d1fa87ddfb9c8e832a30c583b02ded0ac1f31d54'
*/