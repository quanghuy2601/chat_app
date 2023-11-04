import 'dart:convert';

import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'package:get_ip_address/get_ip_address.dart';

import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
          color: Colors.black,
          margin: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _header(context),
                _inputField(context),
                //_forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: _usernameController,
          decoration: InputDecoration(
            iconColor: Colors.white,
            prefixIconColor: Colors.grey,
            suffixIconColor: Colors.grey,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            hintText: "Username",
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
            fillColor: Colors.white.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: _passwordController,
          decoration: InputDecoration(
            prefixIconColor: Colors.grey,
            suffixIconColor: Colors.grey,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            iconColor: Colors.white,
            hintText: "Password",
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
            fillColor: Colors.white.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(
              Icons.password,
              color: Colors.white,
            ),
          ),
          obscuringCharacter: "*",
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            // Login

            if (await _signin(_usernameController.text, _passwordController.text)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            } else {
              _showDialog(context);
            }
            // try {
            //   var ipAddress = IpAddress(type: RequestType.json);
            //   dynamic data = await ipAddress.getIpAddress();
            //   print(data.toString());
            // } on IpAddressException catch (exception) {
            //   print(exception.message);
            // }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color.fromRGBO(163, 52, 250, 1),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Dont have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Color.fromRGBO(163, 52, 250, 1)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
          child: const Text(
            "Backdoor",
            style: TextStyle(color: Color.fromRGBO(163, 52, 250, 1)),
          ),
        ),
      ],
    );
  }

  Future<bool> _signin(String username, String password) async {
    try {
      final url = Uri.parse('http://localhost:5000/api/auth/login');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "username": username,
          "password": md5Encrypt(password),
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  String md5Encrypt(String input) {
    var bytes = utf8.encode(input);
    var digest = md5.convert(bytes);
    return digest.toString();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Thông báo"),
          content: const Text("Đăng nhập thất bại"),
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

//