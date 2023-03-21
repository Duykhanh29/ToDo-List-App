import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:to_do_list/views/pages/main_page.dart';
import 'package:to_do_list/views/notification/notification_view.dart';
import 'package:to_do_list/views/profile/profile.dart';
import 'package:to_do_list/views/recycle/recycle_view.dart';
import 'package:to_do_list/views/settings/settings.dart';
import 'package:to_do_list/views/pages/sign_in.dart';
import 'package:to_do_list/views/widgets/sub_widget/to_do_detail.dart';
import 'views/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        home: const SignInView(),
        routes: {
          ToDoDetail.routeName: (context) => ToDoDetail(),
          Settings.routeName: (context) => const Settings(),
          Profile.routeName: (context) => const Profile(),
          RecycleView.routeName: (context) => const RecycleView(),
          NotificationView.routeName: (context) => const NotificationView()
        },
      ),
    );
  }
}
