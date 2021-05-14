import 'package:flutter/material.dart';
import 'package:flutter_todo_app_with_provider/domain/data_repository.dart';
import 'package:flutter_todo_app_with_provider/domain/todo_item.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel() {
    todoItems = [];
    fetch();
  }
  final DataRepository _dataRepository = DataRepository();
  late List<TodoItem> todoItems;

  void fetch() async {
    await _dataRepository.getAllTodoItems().then((items) {
      todoItems = items;
      notifyListeners();
    });
  }

  void createTodoItem(String title) async {
    await _dataRepository.createTodoItem(title).then((_) {
      fetch();
    });
  }

  void updateTodoItem(TodoItem item) async {
    await _dataRepository.updateTodoItem(item).then((_) {
      fetch();
    });
  }

  void deleteTodoItem(int id) async {
    await _dataRepository.deleteTodoItem(id).then((_) {
      fetch();
    });
  }
}
