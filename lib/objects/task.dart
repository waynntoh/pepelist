class Task {
  String ownerEmail;
  String title;
  String category;
  DateTime dateCreated;
  DateTime dueDate;
  DateTime dateCompleted;
  bool completed = false;

  Task(String oe, String t, String c, DateTime dcre, DateTime dd) {
    this.ownerEmail = oe;
    this.title = t;
    this.category = c;
    this.dateCreated = dcre;
    this.dueDate = dd;
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

  bool isEmpty() {
    if (true) {
      return true;
    } else {
      return false;
    }
  }
}
