import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/data/provider/todo.dart';

class ToDoListProvider with ChangeNotifier {
  List<ToDo> _list = [
    ToDo(
        1,
        "title01",
        "subtitle01",
        DateTime(2023, 3, 15, 7, 0),
        DateTime(2023, 3, 15, 8, 0),
        true,
        DateTime(2023, 3, 15),
        Colors.orange),
    ToDo(
        2,
        "title02",
        "subtitle02",
        DateTime(2023, 3, 15, 7, 0),
        DateTime(2023, 3, 15, 8, 0),
        false,
        DateTime(2023, 3, 15),
        Colors.orange),
    ToDo(
      3,
      "title03",
      "subtitle02",
      DateTime(2023, 3, 15, 7, 0),
      DateTime(2023, 3, 15, 8, 0),
      true,
      DateTime(2023, 3, 15),
      Colors.red,
    ),
    ToDo(
        4,
        "title04",
        "subtitle02",
        DateTime(
          2023,
          3,
          15,
          7,
        ),
        DateTime(2023, 3, 15, 8, 0),
        false,
        DateTime(2023, 3, 15),
        Colors.red),
    ToDo(
        5,
        "title05",
        "subtitle02",
        DateTime(2023, 3, 15, 7, 0),
        DateTime(2023, 3, 15, 8, 0),
        true,
        DateTime(2023, 2, 15),
        Colors.orange),
    ToDo(6, "title06", "subtitle02", DateTime(2023, 3, 15, 7, 0),
        DateTime(2023, 3, 15, 8, 0), true, DateTime(2023, 3, 15), Colors.green),
  ];
  List<ToDo>? getListToDoList(DateTime date, int value) {
    print("Datetime: $date");
    if (value == 3) {
      return _list
          .where((value) =>
              value.completed == false &&
              (date.day == value.date!.day &&
                  date.month == value.date!.month &&
                  date.year == value.date!.year))
          .toList();
    } else if (value == 2) {
      return _list
          .where((value) =>
              value.completed == true &&
              (date.day == value.date!.day &&
                  date.month == value.date!.month &&
                  date.year == value.date!.year))
          .toList();
    } else {
      return _list
          .where((value) => (date.day == value.date!.day &&
              date.month == value.date!.month &&
              date.year == value.date!.year))
          .toList();
    }
  }

  int get getLength {
    return _list.length;
  }

  set setToDoList(List<ToDo> newList) {
    _list = newList;
    notifyListeners();
  }

  void addToDo(ToDo toDo) {
    _list.add(toDo);
    notifyListeners();
  }

  void deleteToDo(int id) {
    int index = _list.indexWhere((value) => value.id == id);
    if (index >= 0) {
      _list.removeAt(index);
      notifyListeners();
    }
  }

  ToDo findByID(int id) {
    return _list.firstWhere((value) => value.id == id);
  }

  bool checkID(int value) {
    for (int i = 0; i < _list.length; i++) {
      if (value == _list[i].id) {
        return true;
      }
    }
    return false;
  }

  int get generateID {
    int id = _list.length + 1;
    for (int i = 0; i < _list.length; i++) {
      if (!checkID(i + 1)) {
        return i + 1;
      }
    }
    return id;
  }
}
