import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:to_do_list/views/pages/sign_in.dart';
import 'main_page.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late SharedPreferences pref;
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isVisblePassword = false;
  bool isVisbleConfirmPassword = false;
  int countWords(String words) {
    return words.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    initPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: CircleAvatar(
                radius: 100,
                child: Image.network(
                  "https://pwrappscdn.azureedge.net/cvt-3a3cfb79e4f640fb1d9aa0178862c69e659375dd1592cd56e68cf8296cc88b7c/images/page/homepage/connectors-logos/microsoft_todo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Input again";
                } else {
                  String patern =
                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                  final regExp = RegExp(patern);
                  {
                    if (!regExp.hasMatch(value)) {
                      return "Input valid email";
                    } else {
                      return null;
                    }
                  }
                }
              },
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.verified_user_outlined),
                labelText: "username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Input again";
                } else if (countWords(value) < 6) {
                  return "Password contains at least 6 characters";
                } else {
                  return null;
                }
              },
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisblePassword = !isVisblePassword;
                      });
                    },
                    icon: isVisblePassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined)),
                labelText: "password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              obscureText: isVisblePassword,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Input again";
                } else if (value != passwordController.text) {
                  return "Password does not match";
                } else {
                  return null;
                }
              },
              controller: confirmPasswordController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisbleConfirmPassword = !isVisbleConfirmPassword;
                      });
                    },
                    icon: isVisbleConfirmPassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined)),
                labelText: "confirm password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              obscureText: isVisbleConfirmPassword,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                onPressed: registerUser,
                child: const Text(
                  "Register",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Have an account"),
                  const SizedBox(
                    height: 3,
                  ),
                  const Icon(
                    Icons.verified_user_outlined,
                    size: 20,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const SignInView();
                          },
                        ));
                      },
                      child: const Text("Sign In"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registerUser() async {
    final User user = User(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text);

    String jsonString = jsonEncode(user);
    pref.setString("userData", jsonString);
    pref.setBool("isLogin", true);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const MainPage()));
  }

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();
  }
}
