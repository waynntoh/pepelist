class Task {
  String ownerEmail;
  String title;
  String category;
  DateTime dateCreated;
  DateTime dueDate;
  DateTime dateCompleted;
  bool completed;

  Task(String oe, String t, String c, DateTime dcre, DateTime dd,
      DateTime dcom) {
    this.ownerEmail = oe;
    this.title = t;
    this.category = c;
    this.dateCreated = dcre;
    this.dateCompleted = dcom;
    this.completed = false;
  }

  void toggleTaskCompletion(bool b) {
    this.completed = b;
  }
}

// TODO: Delete (For testing only)
class Tasks {
  List<Task> tasks = [];

  Tasks() {
    for (int i = 0; i < 5; i++) {
      Task newTask = Task(
        'hidethepainharold@gmail.com',
        'Buy Eggs',
        'Groceries',
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
      );

      tasks.add(newTask);
    }
  }
}
