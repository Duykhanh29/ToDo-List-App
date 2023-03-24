import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var usernameControllder = TextEditingController();
  var emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late SharedPreferences pref;
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences(context);
  }

  void initPreferences(BuildContext context) async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      user = User.fromJson(jsonDecode(pref.getString("userData")!));
    });
    usernameControllder.text = user!.username;
    emailController.text = user!.email;
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Settings"),
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
                height: 40,
              ),
              const Text("UserName"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: usernameControllder,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.verified_user_outlined,
                      color: Colors.blue),
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("Email"),
              const SizedBox(
                height: 10,
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
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  highlightColor: Colors.red.withOpacity(0.4),
                  splashColor: Colors.yellow.withOpacity(0.5),
                  onTap: () {},
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                      onPressed: () {
                        var isValid = formKey.currentState!.validate();
                        User u = User(
                            username: usernameControllder.text,
                            email: emailController.text,
                            password: state!.u!.password);
                        if (isValid) {
                          state.updateInfor(u);
                          String jsonString = jsonEncode(u);
                          pref.setString("userData", jsonString);
                        } else {
                          print("Update fail");
                        }
                      },
                      child: const Text("Update")),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
