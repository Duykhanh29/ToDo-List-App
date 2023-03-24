import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/views/pages/sign_in.dart';
import 'package:to_do_list/views/settings/widgets/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/views/settings/widgets/security.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  static String routeName = "/settings";
  late SharedPreferences pref;
  void logout() async {
    pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Cancel booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to cancel booking?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                pref = await SharedPreferences.getInstance();
                pref.setBool("isLogin", false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SignInView()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Again');
    final state = StateContainer.of(context);
    var user = state!.u;
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Column(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        "https://bazaarvietnam.vn/wp-content/uploads/2022/07/Harpers-Bazaar-phim-tham-tu-lung-danh-Conan_04.jpg",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user!.username,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.black54,
              height: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.person_2_outlined,
                color: Colors.cyan,
              ),
              title: const Text("Edit profile"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const EditProfile();
                  },
                ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.security_outlined,
                color: Colors.cyan,
              ),
              title: const Text("Security"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const Security();
                  },
                ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline,
                color: Colors.cyan,
              ),
              title: const Text("Help"),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.visibility_outlined,
                color: Colors.cyan,
              ),
              title: const Text("Dark theme"),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.toggle_off_outlined,
                    color: Colors.cyan,
                    size: 30,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.cyan,
              ),
              title: const Text("Log Out"),
              onTap: () {
                _showAlertDialog(context);
                // logout();
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => const SignInView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
