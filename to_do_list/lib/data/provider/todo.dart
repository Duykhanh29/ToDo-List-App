import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class ToDo with ChangeNotifier {
  int? id;
  String? title;
  String? subtitle;
  DateTime? date;
  DateTime? startingTime;
  DateTime? endingTime;
  bool completed = false;
  Color? color;
  ToDo(this.id, this.title, this.subtitle, this.startingTime, this.endingTime,
      this.completed, this.date, this.color);
  ToDo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        subtitle = json["subtitle"],
        startingTime = json["startingTime"],
        endingTime = json["endingTime"],
        completed = json["completed"],
        color = json["color"],
        date = json["date"];
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "startingTime": startingTime,
        "endingTime": endingTime,
        "completed": completed,
        "date": date,
        "color": color
      };
  void changeCompleted() {
    completed = !completed;
    notifyListeners();
  }

  void editToDo(
      {String? newTitle,
      String? newNote,
      DateTime? newStartTime,
      DateTime? newEndTime,
      DateTime? newDate}) {
    title = newTitle;
    subtitle = newNote;
    startingTime = newStartTime;
    endingTime = newEndTime;
    date = newDate;
    notifyListeners();
  }
  // hơư

  void changeColor(Color c) {
    color = c;
    notifyListeners();
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
        date = value;
        notifyListeners();
      }
    });
  }

  void selectStartTime(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      showTitleActions: true,
      onChanged: (time) {
        // print('onChanged time: $time');
      },
      onConfirm: (time) {
        startingTime = time;
        notifyListeners();
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
        // if (time.compareTo(startingTime!) > 0) {
        //   return const SnackBar(content: Text("Input again"));
        // } else {
        endingTime = time;
        notifyListeners();
        // }
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  Future<DateTime> chooseDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 2),
      ),
    ).then((value) {
      if (value == null) {
        return null!;
      } else {
        //  date = value;
        //    notifyListeners();
        return value;
      }
    });
  }
}
