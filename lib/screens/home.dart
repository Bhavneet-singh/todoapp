import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/models/todo.dart';

import 'package:todoapp/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todolist = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  //this will have the
  void initState() {
    // TODO: implement initState
    _foundToDo = todolist;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _searchBox(),
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
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: 'Add a new task', border: InputBorder.none),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_todoController.text != '') {
                      _addToDoItem(_todoController.text);
                    } else {}
                    _todoController.clear();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16, bottom: 16),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: tdBlue),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _searchBox() {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child:  TextField(
                  onChanged: (value) => _searchFunctionality(value),
                  decoration:const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlack,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: tdGrey)),
                ),
              ),
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
                    for (ToDo todo in _foundToDo)
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

  void _addToDoItem(String todo) {
    setState(() {
      todolist.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController.clear();
  }

  void _searchFunctionality(String enteredKeyword) {
    List<ToDo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((element) => element.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = result;
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
