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

// TODO: Delete (For testing only)
class Tasks {
  List<Task> tasks = [];

  Tasks() {
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Buy Eggs',
        'Groceries',
        DateTime.now(),
        DateTime.now(),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Web Assignment',
        'Work',
        DateTime.now(),
        DateTime.now(),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Watch memes',
        'Personal',
        DateTime.now(),
        DateTime.now(),
      ),
    );
  }
}
