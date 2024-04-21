import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/search_box.dart';
import 'package:todoapp/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todolist = ToDo.todoList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                const SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (ToDo todo in todolist)
                        ToDoTile(
                          todo: todo,
                          onToDoChange: _handleToDoChange,
                          onDelete: _handleDeletion,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Add a new task', border: InputBorder.none),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: tdBlue,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    height: 60,
                    width: 60,
                    child: const Icon(
                      Icons.add,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
              )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeletion(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/image.jpg')),
          )
        ],
      ),
      backgroundColor: tdBGColor,
    );
  }
}
