import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:to_do_list/views/pages/sign_in.dart';
import 'package:to_do_list/views/widgets/sub_widget/add_to_do.dart';
import '../widgets/sub_widget/list_to_do.dart';
import 'drawer.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Options {
  // ignore: constant_identifier_names
  DONE,
  // ignore: constant_identifier_names
  UNFINISHED,
  // ignore: constant_identifier_names
  ALL
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  // static String routeName = "";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int option = 1;
  DateTime selectedDate = DateTime.now();
  late SharedPreferences pref;
  User? user;

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("TO DO LIST"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: Options.DONE,
                child: Text("Done ToDo"),
              ),
              const PopupMenuItem(
                value: Options.UNFINISHED,
                child: Text("Unfinished ToDo"),
              ),
              const PopupMenuItem(
                value: Options.ALL,
                child: Text("All"),
              ),
            ],
            onSelected: (Options options) {
              setState(() {
                if (options == Options.ALL) {
                  option = 1;
                } else if (options == Options.DONE) {
                  option = 2;
                } else {
                  option = 3;
                }
              });
            },
          ),
          IconButton(
              onPressed: logout, icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                top: 6,
                right: 3,
                left: 20.0,
              ),
              child: DatePicker(
                DateTime(2023, 3, 15),
                width: 80,
                height: 100,
                selectedTextColor: Colors.pink,
                deactivatedColor: Colors.orange,
                initialSelectedDate: DateTime.now(),
                daysCount: 40,
                onDateChange: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
            ),
            const Divider(
              color: Colors.indigoAccent,
            ),
            ListToDo(
              option: option,
              date: selectedDate,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              //   print("Nani: ${provider.getLength}");
              return AddToDo();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
      //),
    );
  }

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      user = User.fromJson(jsonDecode(pref.getString("userData")!));
    });
  }

  void logout() async {
    pref.setBool("isLogin", false);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const SignInView()));
  }
}
