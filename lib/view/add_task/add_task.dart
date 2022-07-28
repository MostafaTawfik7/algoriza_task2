import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/controllers/cubit/cubit.dart';
import 'package:todo_app/controllers/state/state.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/shered/componants.dart';
import 'package:todo_app/view/home/home_screen.dart';

class AddTask extends StatefulWidget {
  Task? task;
  AddTask({Key? key, this.task}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController deadlineController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  TextEditingController endTimeController = TextEditingController();

  TextEditingController remindController = TextEditingController();

  TextEditingController repeatController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      deadlineController.text = widget.task!.deadline;
      startTimeController.text = widget.task!.startTime;
      endTimeController.text = widget.task!.endTime;
      remindController.text = widget.task!.remind;
      repeatController.text = widget.task!.repeat;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ToDoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.task != null ? 'Update task' : 'Add task',
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                  ),
                  onPressed: () {
                    if (widget.task != null) {
                      Navigator.pop(context);
                    }
                    Navigator.pop(context);
                  }),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Title'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: titleController,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Design team meeting',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter value';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text('Deadline'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: deadlineController,
                        readOnly: true,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: (365 * 5))))
                              .then((value) {
                            String deadline = value.toString().substring(0, 10);
                            debugPrint(deadline);
                            deadlineController.text = deadline;
                          }).catchError((error) {
                            debugPrint(error.toString());
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter value';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: '2022-05-28',
                            suffixIcon:
                                Icon(Icons.keyboard_arrow_down_outlined)),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Start time'),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: startTimeController,
                                  readOnly: true,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      String startTime =
                                          value!.format(context).toString();
                                      debugPrint(startTime);
                                      startTimeController.text = startTime;
                                    }).catchError((error) {
                                      debugPrint(error.toString());
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'you must enter value';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: '10:00 Am',
                                      suffixIcon: Icon(
                                        Icons.watch_later_outlined,
                                        size: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('End time'),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: endTimeController,
                                  readOnly: true,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      String endTime =
                                          value!.format(context).toString();
                                      debugPrint(endTime);
                                      endTimeController.text = endTime;
                                    }).catchError((error) {
                                      debugPrint(error.toString());
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'you must enter value';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: '14:00 Pm',
                                      suffixIcon: Icon(
                                        Icons.watch_later_outlined,
                                        size: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Remind'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showMenu(
                                  color: Colors.teal,
                                  context: context,
                                  position: const RelativeRect.fromLTRB(
                                      25, 380, 0, 100),
                                  items: cubit.itemsOfRemind)
                              .then((value) {
                            debugPrint(value.toString());
                            remindController.text = value!.toString();
                          }).catchError((error) {
                            debugPrint(error.toString());
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter value';
                          }
                          return null;
                        },
                        controller: remindController,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        decoration: const InputDecoration(
                            hintText: '10 minutes early',
                            suffixIcon:
                                Icon(Icons.keyboard_arrow_down_outlined)),
                      ),
                      const SizedBox(height: 12),
                      const Text('Repeat'),
                      const SizedBox(height: 8),
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showMenu(
                                  color: Colors.teal,
                                  context: context,
                                  position: const RelativeRect.fromLTRB(
                                      25, 380, 0, 100),
                                  items: cubit.itemsOfRepeat)
                              .then((value) {
                            debugPrint(value);
                            repeatController.text = value!;
                          }).catchError((error) {
                            debugPrint(error.toString());
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter value';
                          }
                          return null;
                        },
                        controller: repeatController,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        decoration: const InputDecoration(
                            hintText: 'Weekly',
                            suffixIcon:
                                Icon(Icons.keyboard_arrow_down_outlined)),
                      ),
                      const SizedBox(height: 40),
                      DefaultButton(
                          onPressed: () {
                            Task task = Task(
                                title: titleController.text,
                                deadline: deadlineController.text,
                                startTime: startTimeController.text,
                                endTime: endTimeController.text,
                                remind: remindController.text,
                                repeat: repeatController.text);

                            if (formKey.currentState!.validate()) {
                              if (widget.task != null) {
                                cubit.updateTask(
                                    task: task, id: widget.task!.id);

                                Navigator.pop(context);
                              } else {
                                cubit.insertInDB(task: task);

                                Navigator.pop(context);
                              }
                              List<int> list1 =
                                  cubit.getReminder(remind: task.remind);
                              String startTimeAfterSubtractREmind =
                                  cubit.afterSubtractRminder(
                                      remindHour: list1[0],
                                      remindMinutes: list1[1],
                                      startTime: task.startTime);
                              List<int> list = cubit.getHoursAndMinutes(
                                  startTime: startTimeAfterSubtractREmind);
                              notifyHelper.displayScheduleNotifications(
                                  hour: list[0], minutes: list[1], task: task);

                              debugPrint('deadline check');
                              cubit.getAllTasks();
                              navigatorAndRemove(
                                  context: context, widget: const HomeScreen());
                            }
                          },
                          text: widget.task != null
                              ? 'Update Task'
                              : 'Create Task'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
