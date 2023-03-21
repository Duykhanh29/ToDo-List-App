import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Duy Khanh"),
            accountEmail: Text("duykhanh0220@gmail.com"),
            currentAccountPicture: CircleAvatar(
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
              Navigator.of(context).pushNamed('/');
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
          ListTile(
            leading: const Icon(Icons.person_2_outlined),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
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
