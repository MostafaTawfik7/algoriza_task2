import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controllers/cubit/cubit.dart';
import '../../../controllers/state/state.dart';
import '../../../shered/componants.dart';
import '../../../shered/theme.dart';

class CompleteTasks extends StatelessWidget {
  const CompleteTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int newindex = 0;
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ToDoCubit.get(context);
          return cubit.completetasks.isNotEmpty
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
                        task: cubit.completetasks[index],
                      );
                    },
                    itemCount: cubit.completetasks.length,
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
                      'you must complete some tasks',
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
