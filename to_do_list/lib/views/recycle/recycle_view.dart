import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecycleView extends StatelessWidget {
  const RecycleView({super.key});
  static String routeName = "/recycle";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recycle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(),
      ),
    );
  }
}
