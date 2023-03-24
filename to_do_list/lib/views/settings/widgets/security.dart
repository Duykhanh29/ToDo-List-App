import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/data/inherited_widget/share_preference.dart';
import 'package:to_do_list/views/settings/widgets/change_password.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool isOpenFaceID = false;
  bool isOpenTouchID = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
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
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            ListTile(
              splashColor: Colors.amber,
              focusColor: Colors.pink,
              leading: const Text("Face ID"),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isOpenFaceID = !isOpenFaceID;
                    });
                  },
                  icon: isOpenFaceID
                      ? const Icon(
                          Icons.toggle_on,
                          color: Colors.red,
                          size: 40,
                        )
                      : const Icon(
                          Icons.toggle_off_outlined,
                          color: Colors.red,
                          size: 40,
                        )),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: Colors.black26,
              height: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              leading: const Text("Touch ID"),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isOpenTouchID = !isOpenTouchID;
                    });
                  },
                  icon: isOpenTouchID
                      ? const Icon(
                          Icons.toggle_on,
                          color: Colors.red,
                          size: 40,
                        )
                      : const Icon(
                          Icons.toggle_off_outlined,
                          color: Colors.red,
                          size: 40,
                        )),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: Colors.black26,
              height: 2,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const ChangePassword();
                      },
                    ));
                  },
                  child: const Text("Change password")),
            )
          ],
        ),
      ),
    );
  }
}
