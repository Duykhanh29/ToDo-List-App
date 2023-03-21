import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/data/provider/todo.dart';

class ListRecycle with ChangeNotifier {
  List<ToDo> _list = [];
  List<ToDo> get getList {
    return _list;
  }

  int get getLength {
    return _list.length;
  }

  void addIntoRecycleBin(ToDo toDo) {
    _list.add(toDo);
    notifyListeners();
  }

  void restoreAToDo(ToDo toDo) {
    notifyListeners();
  }
}
