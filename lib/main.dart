import 'package:flutter/material.dart';
import 'package:flutter_todo_app_with_provider/view/todo_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App With Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListView(),
    );
  }
}
