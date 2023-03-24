import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:to_do_list/views/pages/get_started.dart';
import 'package:to_do_list/views/pages/load_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashPage extends StatefulWidget {
  const FlashPage({super.key});

  @override
  State<FlashPage> createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewLaunch();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              // User user = User(username: "fdsa", email: "", password: "");
              // return StateContainer(user: user, child:
              return newLaunch ? LoadPage() : const GetStarted();
            })));
  }

  late SharedPreferences pref;
  var newLaunch = false;

  void loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      bool _newLaunch = ((pref.getBool('newLaunch') ?? false));
      newLaunch = _newLaunch;
      print("newLaunch: ${newLaunch}");
      // var data = (pref.getString("userData"));
      // user = User.fromJson(jsonDecode(data!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('ToDo List App',
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
