import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/controllers/cubit/cubit.dart';
import 'package:todo_app/shered/theme.dart';
import 'package:todo_app/view/home/home_screen.dart';
import 'controllers/bloc_observer/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit()..createOrOpenDB(),
      child: MaterialApp(
        title: 'ToDo App',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
