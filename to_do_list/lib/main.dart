import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:to_do_list/views/pages/flash.dart';
import 'package:to_do_list/views/pages/load_page.dart';
import 'package:to_do_list/views/pages/main_page.dart';
import 'package:to_do_list/views/notification/notification_view.dart';
import 'package:to_do_list/views/logout/profile.dart';
import 'package:to_do_list/views/recycle/recycle_view.dart';
import 'package:to_do_list/views/settings/settings.dart';
import 'package:to_do_list/views/pages/sign_in.dart';
import 'package:to_do_list/views/widgets/sub_widget/to_do_detail.dart';
import 'views/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './data/inherited_widget/inherited_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    print("object");
    return StateContainer(
      user: User(username: "username", email: "email", password: "password"),
      // onLogin: (user) {
      //   String jsonString = jsonEncode(user);
      //   //sharedPreferences.setString("userData", jsonString);
      //   sharedPreferences.setBool("isLogin", true);
      //   final authState = InheritedContainber.of(context);
      //   authState!.updateShouldNotify(authState);
      // },
      // onLogout: () {
      //   sharedPreferences.setBool("isLogin", false);
      //   final authState = InheritedContainber.of(context);
      //   authState!.updateShouldNotify(authState);
      // },
      // onRegister: (user) {
      //   String jsonString = jsonEncode(user);
      //   sharedPreferences.setString("userData", jsonString);
      //   sharedPreferences.setBool("isLogin", true);
      //   final authState = InheritedContainber.of(context);
      //   authState!.updateShouldNotify(authState);
      // },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ToDoListProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const FlashPage(),
          routes: {
            ToDoDetail.routeName: (context) => ToDoDetail(),
            Settings.routeName: (context) {
              var data = sharedPreferences.getString("userData");
              User user = User.fromJson(jsonDecode(data!));
              print("User nha: ${user.username}");
              return Settings();
            },
            Profile.routeName: (context) => const Profile(),
            RecycleView.routeName: (context) => const RecycleView(),
            NotificationView.routeName: (context) => const NotificationView()
          },
        ),
      ),
    );
  }
}
