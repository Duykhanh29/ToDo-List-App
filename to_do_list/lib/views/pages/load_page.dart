import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:to_do_list/views/pages/main_page.dart';
import 'package:to_do_list/views/pages/sign_in.dart';

class LoadPage extends StatefulWidget {
  LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  late SharedPreferences pref;
  var isLogin = false;

  void loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      bool _isLogin = ((pref.getBool('isLogin') ?? false));
      isLogin = _isLogin;
      print("IsLogin: ${isLogin}");
      // var data = (pref.getString("userData"));
      // user = User.fromJson(jsonDecode(data!));
    });
  }

  @override
  void initState() {
    loadNewLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // User newUser = user;
    //final state = StateContainer.of(context)!.updateInfor(user!);
    return
        // StateContainer(
        //     user: user, child:
        isLogin ? const MainPage() : const SignInView();
  }
}

// seem it is true at this file
