import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  TextEditingController _textController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.trim().isNotEmpty) {
      setState(() {
        _todoItems.add(task);
        _textController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Empty value is not allow!!!"),
        ),
      );
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_todoItems[index]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeTodoItem(index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'MY TODO LIST',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter your task....',
              contentPadding: EdgeInsets.all(16.0),
            ),
            onSubmitted: _addTodoItem,
          ),
          Expanded(
            child: _buildTodoList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoItem(_textController.text),
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
