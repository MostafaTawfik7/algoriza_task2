import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/controllers/cubit/cubit.dart';
import 'package:todo_app/controllers/state/state.dart';

import '../../model/task.dart';
import '../../shered/componants.dart';
import '../../shered/theme.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);
  DatePickerController datePickerController = DatePickerController();
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    int newindex = 0;
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ToDoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Schedule',
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: DatePicker(
                    DateTime.now(),
                    width: 60,
                    height: 80,
                    controller: datePickerController,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.green,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      cubit.changeDate(date);
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit.day,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(cubit.datetime)
                    ],
                  ),
                ),
                Expanded(
                  child: cubit.tasksOfDay.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              late Color color;
                              if (newindex > MyTheme.colors.length - 1 ||
                                  index == 0) {
                                newindex = 0;
                              }
                              // debugPrint(
                              //     DateFormat.jm().format(DateTime.now()));
                              // debugPrint(newindex.toString());
                              color = getColorsForTaskList(index: newindex);
                              newindex++;
                              debugPrint(cubit.tasksOfDay[index].startTime);
                              // if (checkdeadline(
                              //         task: cubit.tasksOfDay[index]) !=
                              //     null) {
                              //   notifyHelper.displayScheduleNotifications(
                              //       duration: checkdeadline(
                              //           task: cubit.tasksOfDay[index])!,
                              //       task: cubit.tasksOfDay[index]);
                              // }
                              return buildItemOfSchedule(
                                task: cubit.tasksOfDay[index],
                                color: color,
                              );
                            },
                            itemCount: cubit.tasksOfDay.length,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/task.svg',
                              height: 150,
                              width: 150,
                              color: Colors.teal,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'you must add some tasks',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        });
  }
}

class buildItemOfSchedule extends StatelessWidget {
  Task task;
  Color color;
  buildItemOfSchedule({Key? key, required this.task, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: color,
          child: ListTile(
            title: Text(
              task.startTime,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              task.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              task.isComplete == 1
                  ? Icons.check_circle_outlined
                  : Icons.circle_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
