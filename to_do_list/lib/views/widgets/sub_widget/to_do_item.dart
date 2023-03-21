import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:to_do_list/data/provider/todo.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/views/widgets/sub_widget/to_do_detail.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<ToDo>(
        context); // we use listen true because When We delete Item it will listen the change and update the change

    final provider =
        Provider.of<ToDoListProvider>(context, listen: false); //truoc co false

    return GestureDetector(
      onTap: () {
        print("ID: ${todo.id}");
        Navigator.pushNamed(context, ToDoDetail.routeName,
            arguments: todo.id.toString());
      },
      child: Dismissible(
        key: Key(todo.id.toString()),
        background: Container(
          color: Colors.black,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.blue,
          ),
        ),
        onDismissed: (direction) {
          ToDo toDo = provider.findByID(todo.id!);
          Provider.of<ToDoListProvider>(context, listen: false)
              .deleteToDo(toDo.id!);
          print(provider.getLength);
        },
        direction: DismissDirection.endToStart,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: todo.color!,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: const Offset(0.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: -15.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          todo.title!,
                          style: todo.completed
                              ? const TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2.0,
                                  decorationColor: Colors.cyanAccent,
                                )
                              : const TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.timer,
                          color: Colors.deepPurpleAccent,
                        ),
                        Text(
                          "${DateFormat.jm().format(todo.startingTime!)} - ${DateFormat.jm().format(todo.endingTime!)}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Consumer<ToDo>(
                  builder: (context, value, child) => IconButton(
                      onPressed: () {
                        todo.changeCompleted();
                      },
                      icon: todo.completed
                          ? const Icon(
                              Icons.check_box,
                              color: Colors.deepPurple,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                            )),
                ),
              )
            ],
          ),
        ),
        //child:
        // ),
      ),
    );
  }
}
