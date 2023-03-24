import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/views/pages/load_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late SharedPreferences pref;
  var isLogin = false;

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  void registerUser() async {
    if (pref.containsKey("newLaunch")) {
      pref.setBool('newLaunch', true);
    } else {
      pref.setBool('newLaunch', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 9.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.cyanAccent, Colors.cyanAccent],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(150),
                  bottomLeft: Radius.circular(150),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const SizedBox(
              height: 320,
              width: double.infinity,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    "https://is3-ssl.mzstatic.com/image/thumb/Purple112/v4/f0/cc/2a/f0cc2a88-d297-4ad4-04e0-05529890afae/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 140,
              width: 200,
              child: Center(
                child: Text(
                  "Make it easy to plan your everyday tasks and assignments. With just few steps your are all set for the whole week, or a month. It is up to you.",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      registerUser();
                      return LoadPage();
                    },
                  ));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                child: const Text("Get started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
