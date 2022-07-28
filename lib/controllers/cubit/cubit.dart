import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:todo_app/controllers/state/state.dart';

import '../../model/task.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());
  static ToDoCubit get(context) => BlocProvider.of(context);

  List<PopupMenuEntry<dynamic>> itemsOfRepeat = [
    const PopupMenuItem<String>(
        value: "None",
        child: Text(
          "None",
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: "Daily",
        child: Text(
          "Daily",
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: "Weekly",
        child: Text(
          "Weekly",
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: "Monthly",
        child: Text(
          "Monthly",
          style: TextStyle(color: Colors.white),
        )),
  ];

  List<PopupMenuEntry<dynamic>> itemsOfRemind = [
    const PopupMenuItem<String>(
        value: '5 m',
        child: Text(
          '5 minutes before',
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: '10 m',
        child: Text(
          '10 minutes before',
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: '30 m',
        child: Text(
          '30 minutes before',
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: '1 h',
        child: Text(
          '1 hour before',
          style: TextStyle(color: Colors.white),
        )),
    const PopupMenuItem<String>(
        value: '24 h',
        child: Text(
          '1 day before',
          style: TextStyle(color: Colors.white),
        )),
  ];

  late Database database;
  List<Task> alltasks = [];
  List<Task> completetasks = [];
  List<Task> unCompletetasks = [];
  List<Task> favoritetasks = [];
  List<Task> tasksOfDay = [];

  void createOrOpenDB() async {
    var databasesPath = await getDatabasesPath();

    String path = p.join(databasesPath, 'todo.db');

    openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, deadline TEXT, starttime TEXT, endtime TEXT, remind TEXT, repeat TEXT, iscomplete INTEGER, isfavorite INTEGER)');
      debugPrint("DataBase is created");
      emit(ToDoCreateDB());
    }, onOpen: (db) {
      debugPrint('DateBase is opened');
      emit(ToDoOpenDB());
    }).then((value) {
      database = value;
      debugPrint(value.isOpen.toString());
      emit(ToDoSuccessDB());
      getAllTasks();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ToDoErrorINDB());
    });
  }

  void insertInDB({required Task task}) async {
    emit(ToDoInsertDB());
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title, deadline, starttime, endtime, remind, repeat, iscomplete, isfavorite) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
          [
            task.title,
            task.deadline,
            task.startTime,
            task.endTime,
            task.remind,
            task.repeat,
            task.isComplete,
            task.isFavorite
          ]).then((value) {
        debugPrint(value.toString());
        emit(ToDoSuccessDB());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(ToDoErrorINDB());
      });
    });
  }

  void getAllTasks() {
    alltasks = [];
    completetasks = [];
    unCompletetasks = [];
    favoritetasks = [];
    emit(ToDoGetTasksDB());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        alltasks.add(Task.fromMap(element));
      }
      for (var element in alltasks) {
        if (element.isFavorite == 1) {
          favoritetasks.add(element);
        }
        if (element.isComplete == 0) {
          unCompletetasks.add(element);
        } else if (element.isComplete == 1) {
          completetasks.add(element);
        }
      }
      debugPrint(alltasks[0].title);
      debugPrint(value.toString());
      emit(ToDoSuccessDB());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ToDoErrorINDB());
    });
  }

  void updateTasksttoComplete({required int id, required int isComplete}) {
    emit(ToDoUpdateCompleteTasksDB());
    if (isComplete == 1) {
      isComplete = 0;
    } else {
      isComplete = 1;
    }
    database.rawUpdate('UPDATE tasks SET iscomplete = ? WHERE id = ?',
        [isComplete, id]).then((value) {
      getAllTasks();
      emit(ToDoSuccessDB());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ToDoErrorINDB());
    });
  }

  void updateTasksttoFavorite({required int id, required int isFavorite}) {
    emit(ToDoUpdateFavoriteTasksDB());
    if (isFavorite == 1) {
      isFavorite = 0;
    } else {
      isFavorite = 1;
    }
    database.rawUpdate('UPDATE tasks SET isfavorite = ? WHERE id = ?',
        [isFavorite, id]).then((value) {
      getAllTasks();
      emit(ToDoSuccessDB());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ToDoErrorINDB());
    });
  }

  void getTasksByDeadline({required String date}) {
    tasksOfDay = [];

    for (var element in alltasks) {
      if (element.deadline == date || element.repeat == 'Daily') {
        tasksOfDay.add(element);
      }
    }
    emit(ToDoGetTasksOfSchedule());
  }

  String datetime = DateFormat('d MMM, yyyy').format(DateTime.now());
  String day = DateFormat('EEEEE', 'en_US').format(DateTime.now()).toString();
  void changeDate(DateTime date) {
    getTasksByDeadline(date: date.toString().substring(0, 10));
    datetime = DateFormat('d MMM, yyyy').format(date);
    day = DateFormat('EEEEE', 'en_US').format(date).toString();
    emit(ChangeDateStateInSchedule());
  }

  void deleteRecordDB({required int id}) {
    emit(ToDoDeleteRecordDB());
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      debugPrint(value.toString());
      emit(ToDoSuccessDB());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ToDoErrorINDB());
    });
  }

  void updateTask({required Task task, required int id}) {
    emit(ToDoUpdateTaskDB());

    database.rawUpdate(
        'UPDATE tasks SET title = ?, deadline = ?, starttime = ?, endtime = ?, remind = ?, repeat = ? WHERE id = ?',
        [
          task.title,
          task.deadline,
          task.startTime,
          task.endTime,
          task.remind,
          task.repeat,
          id
        ]).then((value) {
      emit(ToDoSuccessDB());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ToDoErrorINDB());
    });
  }

  List<int> getHoursAndMinutes({required String startTime}) {
    int hour = int.parse(startTime.split(':')[0]);
    int minute = int.parse((startTime.split(':')[1]).split(' ')[0]);
    List<int> list = [];
    list.add(hour);
    list.add(minute);
    return list;
  }

  String afterSubtractRminder(
      {required String startTime,
      required int remindHour,
      required int remindMinutes}) {
    DateTime dateStart = DateFormat('hh:mm aaa').parse(startTime);
    DateTime dateRemind =
        dateStart.subtract(Duration(hours: remindHour, minutes: remindMinutes));

    String date = DateFormat.jm().format(dateRemind);
    //debugPrint('this is getasd ${date}');
    return date;
  }

  List<int> getReminder({required String remind}) {
    List<int> list = [];
    int hours = 0;
    int minutes = 0;
    if (remind.contains('m')) {
      minutes = int.parse(remind.split(' ')[0]);
    } else {
      hours = int.parse(remind.split(' ')[0]);
    }
    list.add(hours);
    list.add(minutes);
    return list;
  }
}
