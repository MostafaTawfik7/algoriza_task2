class Task {
  late int id;
  late String title;
  late String deadline;
  late String startTime;
  late String endTime;
  late String remind;
  late String repeat;
  late int isComplete;
  late int isFavorite;
  Task(
      {required this.title,
      required this.deadline,
      required this.startTime,
      required this.endTime,
      required this.remind,
      required this.repeat,
      this.isComplete = 0,
      this.isFavorite = 0});

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    deadline = map['deadline'];
    startTime = map['starttime'];
    endTime = map['endtime'];
    remind = map['remind'];
    repeat = map['repeat'];
    isComplete = map['iscomplete'];
    isFavorite = map['isfavorite'];
  }
}
