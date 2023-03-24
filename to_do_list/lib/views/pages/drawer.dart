import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:to_do_list/views/pages/main_page.dart';
import 'package:to_do_list/views/pages/sign_in.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  // User? user;
  late SharedPreferences pref;
  void logout() async {
    pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    var user1 = state!.u;
    print('Print in Drawer:  ${user1!.username} and ${user1.password}');
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user1.username),
            accountEmail: Text(user1.email),
            currentAccountPicture: const CircleAvatar(
              radius: 60,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://cdn.popsww.com/blog/sites/2/2022/02/Edogawa-Conan-.jpg"),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const MainPage();
                },
              ));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notification'),
            onTap: () {
              Navigator.of(context).pushNamed('/notification');
            },
          ),
          const Divider(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_outline_outlined),
            title: const Text('Recycle'),
            onTap: () {
              Navigator.of(context).pushNamed('/recycle');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
    );
  }
}
