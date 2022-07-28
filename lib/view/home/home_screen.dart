import 'package:flutter/material.dart';
import 'package:todo_app/controllers/cubit/cubit.dart';
import 'package:todo_app/services/notifications_services.dart';
import 'package:todo_app/shered/componants.dart';
import 'package:todo_app/view/home/componants/all_tasks.dart';
import 'package:todo_app/view/home/componants/complete_tasks.dart';
import 'package:todo_app/view/home/componants/favorite_tasks.dart';
import 'package:todo_app/view/home/componants/uncomplete_tasks.dart';
import 'package:todo_app/view/schedule/schedule_screen.dart';
import '../add_task/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late NotifyHelper notifyHelper;

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.InitializeNotifications();

    controller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Board',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              onPressed: () {
                notifyHelper.displayNotifications(
                    title: 'First Notifications', deadline: '28-05-2022');
                // notifyHelper.displayScheduleNotifications(
                //     hour: 4,
                //     minutes: 14,
                //     task: Task(
                //         title: 'title',
                //         deadline: '25-02-2000',
                //         startTime: 'startTime',
                //         endTime: 'endTime',
                //         remind: '10',
                //         repeat: 'Daily'));
              },
              icon: const Icon(Icons.notifications_outlined)),
          IconButton(
              onPressed: () {
                String date = DateTime.now().toString().substring(0, 10);
                ToDoCubit.get(context).getTasksByDeadline(date: date);
                navigateTo(context: context, widget: ScheduleScreen());
              },
              icon: const Icon(
                Icons.calendar_month,
              )),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TabBar(
                controller: controller,
                indicatorColor: Colors.black,
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Uncompleted",
                  ),
                  Tab(
                    text: "Favorite",
                  ),
                ]),
            Divider(
              height: 0.5,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TabBarView(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      AllTasks(),
                      CompleteTasks(),
                      UncompleteTasks(),
                      FavoriteTasks(),
                    ]),
              ),
            ),
            const SizedBox(height: 20),
            DefaultButton(
                margin: 30,
                onPressed: () {
                  navigateTo(context: context, widget: AddTask());
                },
                text: 'Add Task'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
