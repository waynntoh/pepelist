class Task {
  String ownerEmail;
  String title;
  String category;
  DateTime dateCreated;
  DateTime dueDate;
  bool completed = false;

  Task(String oe, String t, String c, DateTime dcre, DateTime dd,
      bool completed) {
    this.ownerEmail = oe;
    this.title = t;
    this.category = c;
    this.dateCreated = dcre;
    this.dueDate = dd;
    this.completed = completed;
  }

  void toggleTaskCompletion(bool b) {
    this.completed = b;
  }

  void editTask(String title, String category, DateTime dd) {
    this.title = title;
    this.category = category;
    this.dueDate = dd;
  }
}

class Data {
  List<Task> tasks;

  Data() {
    tasks = [];
  }
}
