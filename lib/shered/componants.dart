import 'package:flutter/material.dart';
import 'package:todo_app/controllers/cubit/cubit.dart';
import 'package:todo_app/shered/theme.dart';
import 'package:todo_app/view/add_task/add_task.dart';
import '../model/task.dart';

class DefaultButton extends StatelessWidget {
  String text;
  Function()? onPressed;
  double margin;
  Color color;
  DefaultButton(
      {required this.onPressed,
      required this.text,
      this.margin = 0,
      this.color = Colors.teal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(primary: color),
          child: Text(text)),
    );
  }
}

void navigateTo({required context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigatorAndRemove({required context, required Widget widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

Color getColorsForTaskList({required int index}) {
  return MyTheme.colors[index];
}

class buildTaskWidget extends StatelessWidget {
  Color color;
  Task task;
  buildTaskWidget({
    Key? key,
    required this.color,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ToDoCubit.get(context);
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        color: color,
        child: ListTile(
          onTap: () {
            bulidDeleteAndUpdateWidget(context, cubit);
          },
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                task.isComplete == 1 ? Icons.done_outline : null,
                color: color,
              ),
              onPressed: () {
                cubit.updateTasksttoComplete(
                    id: task.id, isComplete: task.isComplete);
              },
            ),
          ),
          title: Text(
            task.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Deadline : ${task.deadline}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                icon: Icon(
                  task.isFavorite == 1
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: color,
                ),
                onPressed: () {
                  cubit.updateTasksttoFavorite(
                      id: task.id, isFavorite: task.isFavorite);
                }),
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> bulidDeleteAndUpdateWidget(
      BuildContext context, ToDoCubit cubit) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey.shade300,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DefaultButton(
                    onPressed: () {
                      cubit.deleteRecordDB(id: task.id);
                      cubit.getAllTasks();
                      Navigator.pop(context);
                    },
                    text: 'Delete Task',
                    color: Colors.red,
                    margin: 20,
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    onPressed: () {
                      navigateTo(
                          context: context,
                          widget: AddTask(
                            task: task,
                          ));
                    },
                    text: 'Update Task',
                    color: Colors.blue,
                    margin: 20,
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Close',
                    margin: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
