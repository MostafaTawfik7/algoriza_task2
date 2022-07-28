import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controllers/cubit/cubit.dart';
import '../../../controllers/state/state.dart';
import '../../../shered/componants.dart';
import '../../../shered/theme.dart';

class UncompleteTasks extends StatelessWidget {
  const UncompleteTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int newindex = 0;
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ToDoCubit.get(context);
          return cubit.unCompletetasks.isNotEmpty
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
                        task: cubit.unCompletetasks[index],
                      );
                    },
                    itemCount: cubit.unCompletetasks.length,
                  ),
                )
              : Center(
                  child: SvgPicture.asset(
                    'assets/images/task.svg',
                    height: 150,
                    width: 150,
                    color: Colors.teal,
                  ),
                );
        });
  }
}
