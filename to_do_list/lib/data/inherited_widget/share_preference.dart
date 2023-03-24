import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:to_do_list/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends InheritedWidget {
  final User user;
  _StateContainerState data;
  SharedPreferencesProvider(
      {super.key,
      required this.user,
      required super.child,
      required this.data});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class StateContainer extends StatefulWidget {
  Widget child;
  User? user;
  StateContainer({super.key, this.user, required this.child});
  static _StateContainerState? of(BuildContext context) {
    SharedPreferencesProvider? value = (context
        .dependOnInheritedWidgetOfExactType<SharedPreferencesProvider>());
    if (value != null) {
      return value.data;
    }
    return null;
  }

  @override
  State<StateContainer> createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  User? u;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("infor: ${widget.user!.username} and  ${widget.user!.password}");
    u = widget.user;
  }

  void updateInfor(User user2) {
    if (u == null) {
      setState(() {
        u = widget.user;
      });
    } else {
      setState(() {
        u = user2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SharedPreferencesProvider(
        data: this, user: widget.user!, child: widget.child);
  }
}
