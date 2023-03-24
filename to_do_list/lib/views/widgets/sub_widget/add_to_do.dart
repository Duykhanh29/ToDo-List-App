import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/provider/todo.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:intl/intl.dart';

class AddToDo extends StatefulWidget {
  AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  var titleController = TextEditingController();

  var noteController = TextEditingController();
  DateTime startingTime = DateTime.now();
  DateTime endingTime = DateTime.now();
  DateTime date = DateTime.now();
  Color color = Colors.red;
  void selectStartTime(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      showTitleActions: true,
      onChanged: (time) {
        // print('onChanged time: $time');
      },
      onConfirm: (time) {
        setState(() {
          startingTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
          print("Check the first startTime ${startingTime.toString()}");
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void selectEndTime(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      showTitleActions: true,
      onChanged: (time) {
        // print('onChanged time: $time');
      },
      onConfirm: (time) {
        if (time.compareTo(startingTime) <= 0) {
          return const SnackBar(content: Text("Input again"));
        } else {
          setState(() {
            endingTime = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            print("Check the first endTime ${endingTime.toString()}");
          });
        }
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  Future<void> selectDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 2),
      ),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          date = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final listProvider =
        Provider.of<ToDoListProvider>(context); // ban dau co listen false
    var length = listProvider.getLength;
    int id = listProvider.generateID;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add new to do"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "ID",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(id.toString()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 50,
              child: Center(
                  child: Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 50,
              child: Center(
                child: Text(
                  "Note",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: noteController,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 50,
              child: Center(
                child: Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              // padding: const EdgeInsets.only(left: 20, right: 10),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                      width: 100,
                      child:
                          Center(child: Text(DateFormat.yMd().format(date)))),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        await selectDate(context);
                      },
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.indigoAccent,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Center(
                        child: Text(
                          "Start time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Text(
                              DateFormat.jm().format(startingTime),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                selectStartTime(context);
                              },
                              icon: const Icon(
                                Icons.timer,
                                color: Colors.indigoAccent,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Center(
                        child: Text(
                          "End time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Text(DateFormat.jm().format(endingTime)),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              selectEndTime(context);
                            },
                            icon: const Icon(
                              Icons.timer,
                              color: Colors.indigoAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 50,
              child: Center(
                child: Text(
                  "Color",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //  ChooseColor(color: color),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      color = Colors.red;
                    });
                  },
                  icon: color == Colors.red
                      ? const Icon(
                          Icons.check_circle_sharp,
                          color: Colors.red,
                          size: 40,
                        )
                      : const Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 40,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      color = Colors.green;
                    });
                  },
                  icon: color == Colors.green
                      ? const Icon(
                          Icons.check_circle_sharp,
                          color: Colors.green,
                          size: 40,
                        )
                      : const Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 40,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      color = Colors.orange;
                    });
                  },
                  icon: color == Colors.orange
                      ? const Icon(
                          Icons.check_circle_sharp,
                          color: Colors.orange,
                          size: 40,
                        )
                      : const Icon(
                          Icons.circle,
                          color: Colors.orange,
                          size: 40,
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)))),
                  onPressed: () {
                    // ToDo toDo = ToDo(
                    //     id,
                    //     titleController.text,
                    //     noteController.text,
                    //     DateTime.now(),
                    //     DateTime.now(),
                    //     false,
                    //     DateTime.now(),
                    //     color);
                    ToDo toDo = ToDo(
                        id,
                        titleController.text,
                        noteController.text,
                        startingTime,
                        endingTime,
                        false,
                        date,
                        color);
                    listProvider.addToDo(toDo);
                    print("Next id: ${listProvider.generateID}");
                    listProvider.showAll();
                  },
                  child: const Text("Create"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
