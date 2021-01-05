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
        'Clean bathroom',
        'Personal',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: 5),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Buy eggs',
        'Groceries',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: 7),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Print document',
        'Work',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: -1),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Hit boss',
        'Work',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: 1),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Reflect actions',
        'Personal',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: 1),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Web assignment',
        'School',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: -10),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'Buy new fan',
        'Home',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: 15),
        ),
      ),
    );
    tasks.add(
      Task(
        'hidethepainharold@gmail.com',
        'End world hunger',
        'Other',
        DateTime.now(),
        DateTime.now().add(
          Duration(days: 31),
        ),
      ),
    );
  }
}
