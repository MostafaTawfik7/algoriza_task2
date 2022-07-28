abstract class ToDoStates {}

class ToDoInitialState extends ToDoStates {}

class ToDoCreateDB extends ToDoStates {}

class ToDoOpenDB extends ToDoStates {}

class ToDoSuccessDB extends ToDoStates {}

class ToDoErrorINDB extends ToDoStates {}

class ToDoInsertDB extends ToDoStates {}

class ToDoGetTasksDB extends ToDoStates {}

class ToDoGetTasksOfSchedule extends ToDoStates {}

class ToDoDeleteRecordDB extends ToDoStates {}

class ToDoUpdateCompleteTasksDB extends ToDoStates {}

class ToDoUpdateTaskDB extends ToDoStates {}

class ToDoUpdateFavoriteTasksDB extends ToDoStates {}

class ChangeDateStateInSchedule extends ToDoStates {}
