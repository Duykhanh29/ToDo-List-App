import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:to_do_list/data/provider/todo.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ToDoDetail extends StatelessWidget {
  ToDoDetail({super.key});

  static String routeName = "/todo-detail";
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ToDoListProvider>(context, listen: false);
    var todo = provider.findByID(int.parse(productId));
    print("Length: ${provider.getLength}");
    return
        // ChangeNotifierProvider.value(
        //   value: provider,
        //   child:
        ChangeNotifierProvider<ToDo>.value(
      value: todo,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Details to-do"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              onPressed: () {
                provider.deleteToDo(todo.id!);
                //  provider.showAll();
                //  Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const InputToDo(),

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
                  Text(todo.id.toString()),
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
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
              CreateTitle(
                initialText: todo.title,
                titleController: titleController,
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
              CreateNote(
                  initialText: todo.subtitle!, noteController: noteController),
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
                        child: Center(
                            child: Consumer<ToDo>(
                                builder: (context, value, child) => Text(
                                    DateFormat.yMd().format(todo.date!))))),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          todo.selectDate(context);
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
                              child: Consumer<ToDo>(
                                builder: (context, value, child) => Text(
                                  DateFormat.jm().format(todo.startingTime!),
                                ),
                                // child:
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  todo.selectStartTime(context);
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
                              child: Consumer<ToDo>(
                                builder: (context, value, child) => Text(
                                    DateFormat.jm().format(todo.endingTime!)),
                                //  child:
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                todo.selectEndTime(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      todo.changeColor(Colors.red);
                    },
                    icon: Consumer<ToDo>(
                      builder: (context, value, child) =>
                          todo.color == Colors.red
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
                      // child:
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      todo.changeColor(Colors.green);
                    },
                    icon: Consumer<ToDo>(
                      builder: (context, value, child) =>
                          todo.color == Colors.green
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
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      todo.changeColor(Colors.orange);
                    },
                    icon: Consumer<ToDo>(
                      builder: (context, value, child) =>
                          todo.color == Colors.orange
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: Consumer<ToDo>(
                      builder: (context, value, child) => ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(todo.color!),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                        ),
                        onPressed: () {
                          todo.editToDo(
                              newEndTime: DateTime.now(),
                              newDate: DateTime.now(),
                              newStartTime: DateTime.now(),
                              newTitle: titleController.text,
                              newNote: noteController.text);
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      //child:
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: Consumer<ToDo>(
                      builder: (context, value, child) => ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(todo.color!),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15)))),
                          onPressed: () {
                            todo.changeCompleted();
                          },
                          child: todo.completed
                              ? const Text("Uncompleted")
                              : const Text("Completed")),
                      //child:
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}

class CreateTitle extends StatefulWidget {
  CreateTitle(
      {super.key, required this.initialText, required this.titleController});
  final initialText;
  var titleController = TextEditingController();

  @override
  State<CreateTitle> createState() => _CreateTitleState();
}

class _CreateTitleState extends State<CreateTitle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.titleController.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.titleController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CreateNote extends StatefulWidget {
  CreateNote(
      {super.key, required this.initialText, required this.noteController});
  String initialText;
  var noteController = TextEditingController();

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.noteController.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 7,
      controller: widget.noteController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
