import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static String routeName = "/notification";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(),
      ),
    );
  }
}
