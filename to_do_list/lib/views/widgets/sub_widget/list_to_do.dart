import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/provider/to_do_list_provider.dart';
import 'package:to_do_list/data/provider/todo.dart';
import './to_do_item.dart';

class ListToDo extends StatelessWidget {
  ListToDo({super.key, required this.option, required this.date});
  int option;
  DateTime date;

  List<ToDo>? searchList(String title, List<ToDo> _list) {
    List<ToDo>? list;
    for (var element in _list) {
      if (element.title!.contains(title) == true) {
        list!.add(element);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoListProvider>(context); // it must have

    var list = provider.getListToDoList(date, option);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            ToDo toDo = list[index];
            return ChangeNotifierProvider.value(
              value: toDo,
              child: const ToDoItem(),
            );
          },
          itemCount: list!.length,
        ),
      ),
    );
  }
}
