import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var currentPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late SharedPreferences pref;
  bool isVisbleCurrentPassword = false;
  bool isVisbleNewPassword = false;
  bool isVisbleConfirmPassword = false;
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences();
  }

  int countWords(String words) {
    return words.length;
  }

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      user = User.fromJson(jsonDecode(pref.getString("userData")!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Change password"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 20,
                  width: 200,
                  child: Text("Current password"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input again";
                    } else if (value != user!.password) {
                      return "Wrong password";
                    } else {
                      return null;
                    }
                  },
                  controller: currentPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisbleCurrentPassword = !isVisbleCurrentPassword;
                          });
                        },
                        icon: isVisbleCurrentPassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    labelText: "current password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  obscureText: isVisbleCurrentPassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                  width: 200,
                  child: Text("New password"),
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
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisbleNewPassword = !isVisbleNewPassword;
                          });
                        },
                        icon: isVisbleNewPassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    labelText: "new password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  obscureText: isVisbleNewPassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                  width: 200,
                  child: Text("Confirm password"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input again";
                    } else if (value != newPasswordController.text) {
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
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          User u = User(
                              username: user!.username,
                              email: user!.email,
                              password: newPasswordController.text);
                          state!.updateInfor(u);
                          String jsonString = jsonEncode(u);
                          pref.setString("userData", jsonString);
                        } else {
                          print("Update fail");
                        }
                      },
                      child: const Text("Update password")),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )),
      ),
    );
  }
}
