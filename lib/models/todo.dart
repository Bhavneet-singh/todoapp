class ToDo {
  String id;
  String todoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: "Morning Walk ", isDone: true),
      ToDo(id: '02', todoText: "Read a Book", ),
      ToDo(id: '03', todoText: "Study Flutter")
    ];
  }
}
