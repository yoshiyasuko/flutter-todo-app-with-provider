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
    _dataRepository.getAllTodoItems().then((items) {
      todoItems = items;
      notifyListeners();
    });
  }

  void updateTodoItem(TodoItem item) async {
    _dataRepository.updateTodoItem(item).then((_) {
      fetch();
    });
  }

  void deleteTodoItem(int index) async {
    var id = index + 1;
    _dataRepository.deleteTodoItem(id).then((_) {
      fetch();
    });
  }
}
