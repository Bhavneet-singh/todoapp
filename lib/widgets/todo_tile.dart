import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/models/todo.dart';

class ToDoTile extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDelete;
  const ToDoTile(
      {super.key,
      required this.todo,
      required this.onToDoChange,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        onTap: () {
          // print('Clicked on todo tile ');
          onToDoChange(todo);

        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: todo.isDone
            ? const Icon(
                Icons.check_box,
                color: tdBlue,
              )
            : const Icon(
                Icons.check_box_outline_blank,
                color: tdBlue,
              ),
        title: Text(
          todo.todoText,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: tdRed),
          height: 35,
          width: 35,
          child: IconButton(
              onPressed: () {
                // print('Clicked on delete icon');
                onDelete(todo.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
    );
  }
}
