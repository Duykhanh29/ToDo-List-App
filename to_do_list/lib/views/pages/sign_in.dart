import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:to_do_list/views/pages/main_page.dart';
import 'package:to_do_list/views/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late SharedPreferences pref;
  User? user;

  resetNewLaunch() async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("isLogin")) {
      pref.setBool('isLogin', true);
    } else {
      pref.setBool('isLogin', true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    initPreferences(context);
    super.initState();
  }

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisblePassword = false;
  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    var user1 = state!.u;
    print('Print in signIn:  ${user1!.username} and ${user1.password}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CircleAvatar(
                radius: 120,
                child: Image.network(
                  "https://www.pngitem.com/pimgs/m/509-5099434_todo-app-logo-transparent-hd-png-download.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.verified_user_outlined),
                labelText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisblePassword = !isVisblePassword;
                      });
                    },
                    icon: isVisblePassword
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                TextButton(
                    onPressed: () {}, child: const Text("Forgot password?"))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.login_outlined),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                onPressed: () {
                  loginUser(usernameController.text, passwordController.text);
                  if (usernameController.text != user!.username ||
                      passwordController.text != user!.password) {
                    print("Fail to sign in");
                  } else {
                    // final username = usernameController.text.trim();
                    // final password = passwordController.text.trim();
                    // final user1 = User(
                    //     email: user!.email,
                    //     password: password,
                    //     username: username);
                    // InheritedContainber.of(context)!.login(user!);

                    resetNewLaunch();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MainPage()));
                  }
                },
                label: const Text(
                  "Sign In",
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
                  const Text("Don't have an account"),
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
                            return const RegisterView();
                          },
                        ));
                      },
                      child: const Text("Register"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser(String username, String password) async {
    if (username != user!.username || password != user!.password) {
      print("Fail to sign in");
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const MainPage()));
    }
  }

  void initPreferences(BuildContext context) async {
    pref = await SharedPreferences.getInstance();

    // this is used for getting old data ( the latest account). To check when user input alrealdy account
    setState(() {
      user = User.fromJson(jsonDecode(pref.getString("userData")!));
    });
    final state = StateContainer.of(context);
    var user1 = state!.u;
    print("Check 1: ${user!.username} and ${user!.password}");
    print("Check 2: ${user1!.username} and ${user1.password}");
  }
}
