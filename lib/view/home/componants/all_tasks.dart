import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/controllers/cubit/cubit.dart';
import 'package:todo_app/controllers/state/state.dart';
import 'package:todo_app/shered/componants.dart';
import 'package:todo_app/shered/theme.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int newindex = 0;
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ToDoCubit.get(context);

          return cubit.alltasks.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 8),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      late Color color;
                      if (newindex > MyTheme.colors.length - 1 || index == 0) {
                        newindex = 0;
                      }

                      color = getColorsForTaskList(index: newindex);
                      newindex++;

                      return buildTaskWidget(
                        color: color,
                        task: cubit.alltasks[index],
                      );
                    },
                    itemCount: cubit.alltasks.length,
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
                );
        });
  }
}
